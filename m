Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E45C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 14:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiCJOZg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiCJOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:21:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAAAB250C;
        Thu, 10 Mar 2022 06:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D1B0B8254A;
        Thu, 10 Mar 2022 14:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4C5C340E8;
        Thu, 10 Mar 2022 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646921713;
        bh=z8EgcjSQX1uiEBcBEJS+c1a5iDxnSom+wEXnmvXwijE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7IiA4BH9Zl6lcg4UKtmZlrDektV8GzwfWWXvbOnzk0bq9C0+J67oIpC5vKyw76uq
         AiJTGxRmdmXYag4Fb2OJbCrbBi4Z4OTLCjFyDnZ7OGsvjPNwOSr0QChhAiqz7hO5kK
         /YXuXR/KiQ1ASZsc2rHvXBQvUA3qUdGy+4hMEWhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 08/38] x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
Date:   Thu, 10 Mar 2022 15:13:21 +0100
Message-Id: <20220310140808.380805567@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310140808.136149678@linuxfoundation.org>
References: <20220310140808.136149678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit f8a66d608a3e471e1202778c2a36cbdc96bae73b upstream.

Currently Linux prevents usage of retpoline,amd on !AMD hardware, this
is unfriendly and gets in the way of testing. Remove this restriction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.487348118@infradead.org
[fllinden@amazon.com: backported to 4.19 (no Hygon in 4.19)]
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -838,12 +838,6 @@ static enum spectre_v2_mitigation_cmd __
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
 	spec_v2_print_cond(mitigation_options[i].option,
 			   mitigation_options[i].secure);
 	return cmd;


