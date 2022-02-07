Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD7C43217
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiBGLLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355199AbiBGLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:07:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD00C043188;
        Mon,  7 Feb 2022 03:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF1E61261;
        Mon,  7 Feb 2022 11:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF01C004E1;
        Mon,  7 Feb 2022 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232077;
        bh=QNjeopCO/dSjTXBC+kJ8ycJgMjiDarjq3TppLjJXCUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cm6tyIe4Y4qse00koBe44HYcqRSB0JIdVm3JVE5wgiKh4G7xNv/pZbd+vexUg3Bxm
         xQ/MecJN3s608moT3V+RDwPbUfB3X+0hkjJv+ppzlFAN3GnYH9NIXOWdKOJZ7U+4WJ
         xQPVd0pgM/qSDZ7K131yAr67pUsaxQ72rryJS8SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5ca851459ed04c778d1d@syzkaller.appspotmail.com,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: [PATCH 4.9 01/48] can: bcm: fix UAF of bcm op
Date:   Mon,  7 Feb 2022 12:05:34 +0100
Message-Id: <20220207103752.389035382@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103752.341184175@linuxfoundation.org>
References: <20220207103752.341184175@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziyang Xuan <william.xuanziyang@huawei.com>

Stopping tasklet and hrtimer rely on the active state of tasklet and
hrtimer sequentially in bcm_remove_op(), the op object will be freed
if they are all unactive. Assume the hrtimer timeout is short, the
hrtimer cb has been excuted after tasklet conditional judgment which
must be false after last round tasklet_kill() and before condition
hrtimer_active(), it is false when execute to hrtimer_active(). Bug
is triggerd, because the stopping action is end and the op object
will be freed, but the tasklet is scheduled. The resources of the op
object will occur UAF bug.

Move hrtimer_cancel() behind tasklet_kill() and switch 'while () {...}'
to 'do {...} while ()' to fix the op UAF problem.

Fixes: a06393ed0316 ("can: bcm: fix hrtimer/tasklet termination in bcm op removal")
Reported-by: syzbot+5ca851459ed04c778d1d@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/bcm.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -761,21 +761,21 @@ static struct bcm_op *bcm_find_op(struct
 static void bcm_remove_op(struct bcm_op *op)
 {
 	if (op->tsklet.func) {
-		while (test_bit(TASKLET_STATE_SCHED, &op->tsklet.state) ||
-		       test_bit(TASKLET_STATE_RUN, &op->tsklet.state) ||
-		       hrtimer_active(&op->timer)) {
-			hrtimer_cancel(&op->timer);
+		do {
 			tasklet_kill(&op->tsklet);
-		}
+			hrtimer_cancel(&op->timer);
+		} while (test_bit(TASKLET_STATE_SCHED, &op->tsklet.state) ||
+			 test_bit(TASKLET_STATE_RUN, &op->tsklet.state) ||
+			 hrtimer_active(&op->timer));
 	}
 
 	if (op->thrtsklet.func) {
-		while (test_bit(TASKLET_STATE_SCHED, &op->thrtsklet.state) ||
-		       test_bit(TASKLET_STATE_RUN, &op->thrtsklet.state) ||
-		       hrtimer_active(&op->thrtimer)) {
-			hrtimer_cancel(&op->thrtimer);
+		do {
 			tasklet_kill(&op->thrtsklet);
-		}
+			hrtimer_cancel(&op->thrtimer);
+		} while (test_bit(TASKLET_STATE_SCHED, &op->thrtsklet.state) ||
+			 test_bit(TASKLET_STATE_RUN, &op->thrtsklet.state) ||
+			 hrtimer_active(&op->thrtimer));
 	}
 
 	if ((op->frames) && (op->frames != &op->sframe))


