Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3ECCA483
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiGWKL2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiGWKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:09:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8427D1C7;
        Sat, 23 Jul 2022 03:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D525CE0B68;
        Sat, 23 Jul 2022 10:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFDFC341CE;
        Sat, 23 Jul 2022 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658570547;
        bh=/dc3mGi7bQmupPffWgNjejnw/63egPiFRy77Qic0Qag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqAIXbuU37kZSee7jovqxJoGBoCgS2VdKhvwTr+1vQN9JB2xvSyv7IpYeFYKRJzA8
         4E84Qoi+a/nWrW4lN0rpAhHpz9+lPP/OdXJ7+GXfaORZOXP5syh57G1tGl3Z80mzUA
         izEnokMm41c7V9DsbyLK9xs6bxoyut+YmbLBP4p4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.10 135/148] x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit
Date:   Sat, 23 Jul 2022 11:55:47 +0200
Message-Id: <20220723095302.194859866@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723095224.302504400@linuxfoundation.org>
References: <20220723095224.302504400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 3131ef39fb03bbde237d0b8260445898f3dfda5b upstream.

The build on x86_32 currently fails after commit

  9bb2ec608a20 (objtool: Update Retpoline validation)

with:

  arch/x86/kernel/../../x86/xen/xen-head.S:35: Error: no such instruction: `annotate_unret_safe'

ANNOTATE_UNRET_SAFE is defined in nospec-branch.h. And head_32.S is
missing this include. Fix this.

Fixes: 9bb2ec608a20 ("objtool: Update Retpoline validation")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/63e23f80-033f-f64e-7522-2816debbc367@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/head_32.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -23,6 +23,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/percpu.h>
 #include <asm/nops.h>
+#include <asm/nospec-branch.h>
 #include <asm/bootparam.h>
 #include <asm/export.h>
 #include <asm/pgtable_32.h>


