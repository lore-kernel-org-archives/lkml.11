Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiEPK2g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbiEPK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0912A86;
        Mon, 16 May 2022 03:27:37 -0700 (PDT)
Message-ID: <20220516102615.947490347@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1eoy5klb8svAdIn9/UXgJevyTb9Ww/jSlczBpVi7ZNQ=;
        b=rP1Gt0hSMwM7kYHgwY2C/ntB3s+H1l/1S6Km3OE8/0DZSiXO+N34LP58EkR/cK5y5ZA+vl
        rCWdp5xSsaIN6io1zjKsLjBMvlaLBcMUpFxr5/7WhC2sRknoYnhYII+b5BBK8j91zHb8nT
        mwBEvkbCWlzSFQiak01DaUqEyHZpla7pzVWnN27XI3fDcHv8gcy1Sk34rP/2+zY3rVjgac
        DUDprnEnjAC5I55v/zWRtcfdCkdtjVnrNq5ir3arzOKHnsyC9yJEC2XNj+DmdxfJbuGHa9
        YCAeEM6lsU0ulctTwMK154VMv12Y5c92F6x1echwCe6n9er2/w1cZkeemGlsog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1eoy5klb8svAdIn9/UXgJevyTb9Ww/jSlczBpVi7ZNQ=;
        b=lssgXrIntPIE3+KeFtioEjxQhOZYiNdcS54BaTMXZbEgYUywepWrJcAAiZpO710cCWZsWo
        53HbHOG5ATwx3aBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 9/9] scripts/spdxcheck: Exclude top-level README
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:35 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing copyrightable to see here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxexclude |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/spdxexclude
+++ b/scripts/spdxexclude
@@ -21,3 +21,4 @@ arch/*/configs/
 # Other files without copyrightable content
 /CREDITS
 /MAINTAINERS
+/README

