Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 10:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiFBKmj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiFBKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:42:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0322B1951
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:42:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4287B1FB21;
        Thu,  2 Jun 2022 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654166553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=OVsrz606uDdVkY5BsxZXD6SXpBDL9zm4ofWzSCjhhJ4=;
        b=vVYRdSJhvVpOcSm0k8YKlKZddVhjVZ33KHtGmvFP2QBeNWVcihO2V7y2iSXYPJA7Vr9Spm
        BGF7toGebO2V6jpaC8tCh2FgX7ZhMDY/IACs0HDGcLPe/Hn180tQ3oRxTU2iOoPm4OhVY1
        3oAPAqPihiox+N3uvKCs1fenDx69Y7o=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD1892C141;
        Thu,  2 Jun 2022 10:42:32 +0000 (UTC)
Date:   Thu, 2 Jun 2022 12:42:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixup for 5.19
Message-ID: <YpiUGCdJA2UyRWYE@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the revert of wake_up_all callers from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-fixup

=====================================

- Revert inappropriate use of wake_up_interruptible_all() in printk()

----------------------------------------------------------------
John Ogness (1):
      Revert "printk: wake up all waiters"

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
