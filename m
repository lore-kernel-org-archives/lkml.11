Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C90C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 20:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHBUEO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHBUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:04:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411750076;
        Tue,  2 Aug 2022 13:04:10 -0700 (PDT)
Date:   Tue, 02 Aug 2022 20:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659470648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TArMLEdIDIvN1Mr2pZzfeNF4vfqBhPO02hE5okfCN+E=;
        b=QoBy534OqzE+u0hnSpY0jbgIdZ1B0Was0gOMFOraQSwyEFpxDddG0ZVNvn6nR5OzsPSv8Y
        tb8LSrBqAI0dc6wc5vx/PJ/2Gt78ZLduA7s+qtrXe3qCYKb0UBwvtbaBjyP1mJJfwlUZZn
        fo+WMfo9O/UWgN9SI/FcvTZPRLZq/seX4KNY6Z7VfpJ9QERsP5yKYr4/5CgEsbjckFmjve
        YfUt53eqZs4d25Sw7ZXl21UHD/nhihDDWjILXZsFlWeAfK0D04GPtjRaXxYWhUCrZIX5Xr
        ygIHSNDM1N06p2dEazLKR1QZuhd52F1drkG1eQsVm334oRxVfTcztKSSmRe0kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659470648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TArMLEdIDIvN1Mr2pZzfeNF4vfqBhPO02hE5okfCN+E=;
        b=9N2h6O5n+U0IYx3ExOBkmpt5YpJNuE0eoc8uNzLTR40SUwBdv4SydtQWPZZ5kdi07Jzgkc
        CB/D9wwWFzCKxiDA==
From:   "tip-bot2 for Slark Xiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Fix 'the the' typo in comment
Cc:     Slark Xiao <slark_xiao@163.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220725015903.5449-1-slark_xiao@163.com>
References: <20220725015903.5449-1-slark_xiao@163.com>
MIME-Version: 1.0
Message-ID: <165947064693.15455.11100574232413276883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d171011e6adad135eaced630dce26cac9a174037
Gitweb:        https://git.kernel.org/tip/d171011e6adad135eaced630dce26cac9a174037
Author:        Slark Xiao <slark_xiao@163.com>
AuthorDate:    Mon, 25 Jul 2022 09:59:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 21:57:03 +02:00

selftests: futex: Fix 'the the' typo in comment

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220725015903.5449-1-slark_xiao@163.com
---
 tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index f8c43ce..c6b8f32 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -184,7 +184,7 @@ int main(int argc, char *argv[])
 		/*
 		 * If res is non-zero, we either requeued the waiter or hit an
 		 * error, break out and handle it. If it is zero, then the
-		 * signal may have hit before the the waiter was blocked on f1.
+		 * signal may have hit before the waiter was blocked on f1.
 		 * Try again.
 		 */
 		if (res > 0) {
