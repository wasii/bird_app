import UIKit

/// Enum provider for providing the animationTitle and an animation method from the factory
enum TableAnimation {
    case fadeIn(duration: TimeInterval, delay: TimeInterval)
    case moveUp(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpBounce(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    
    // provides an animation with duration and delay associated with the case
    func getAnimation() -> TableCellAnimation {
        switch self {
        case .fadeIn(let duration, let delay):
            return TableAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUp(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpWithFade(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpWithFadeAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpBounce(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        }
    }
    
    // provides the title based on the case
    func getTitle() -> String {
        switch self {
        case .fadeIn(_, _):
            return "Fade-In Animation"
        case .moveUp(_, _, _):
            return "Move-Up Animation"
        case .moveUpWithFade(_, _, _):
            return "Move-Up-Fade Animation"
        case .moveUpBounce(_, _, _):
            return "Move-Up-Bounce Animation"
        }
    }
}

typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

final class TableViewAnimator {
    private let animation: TableCellAnimation
    
    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}

enum TableAnimationFactory {
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
    static func makeMoveUpWithFadeAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight * 1.4)
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }
    static func makeMoveUpAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight * 1.4)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    static func makeMoveUpBounceAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}
