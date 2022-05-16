Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E51C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiEPK1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiEPK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7AE67;
        Mon, 16 May 2022 03:27:25 -0700 (PDT)
Message-ID: <20220516102615.477393627@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AEGNLRsULrrlU/iG+q1/N0tiNN2soHDw9Oun7z7w8C0=;
        b=p2jwGDkqbQBkm+lXvlqfBK0u5WWWvZvqI4NxnyIY2iP+PeNut8VZqH7Q43DM3H80YrGMJk
        Pww1UHxyl4oB0IFQgXfjhJ82sA9kP9GZ9HuLDeAIbi38Ei8VRbwviHqepB2uwzIn5PzV3s
        Y6zoz4pMxdrx+jMKHuJMY78THQGHGoApVnaDsCa/GaXqJbIyVZErNXVkJ98DvLleaes5Ui
        LVcofcSbO49LtwHOGbRUjxZyzaYrSNr1+ohvHo+DhYdCGwKd4XYk49Sf8S/bPChjNUkZTO
        3NzwE4BFt5tw1ReHmc73iWI5kkUPYzbLfIVsynp3hJ1KiKx1sQRCiUrlroaSSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AEGNLRsULrrlU/iG+q1/N0tiNN2soHDw9Oun7z7w8C0=;
        b=nGlg58vyrD65CKCz0DqWjdniKijQ4huOAhsv8NacYDyO9ZCeMzxAsOrRSB4+vm6jB6800/
        59jZ/dd/077x3ZDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 1/9] scripts/spdxcheck: Add percentage to statistics
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files checked:            75856
Lines checked:           294516
Files with SPDX:          59410  78%
Files with errors:            0

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -285,7 +285,9 @@ import os
                 sys.stderr.write('\n')
                 sys.stderr.write('Files checked:     %12d\n' %parser.checked)
                 sys.stderr.write('Lines checked:     %12d\n' %parser.lines_checked)
-                sys.stderr.write('Files with SPDX:   %12d\n' %parser.spdx_valid)
+                if parser.checked:
+                    pc = int(100 * parser.spdx_valid / parser.checked)
+                    sys.stderr.write('Files with SPDX:   %12d %3d%%\n' %(parser.spdx_valid, pc))
                 sys.stderr.write('Files with errors: %12d\n' %parser.spdx_errors)
 
             sys.exit(0)

