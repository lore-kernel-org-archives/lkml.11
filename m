Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66EC32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359093AbiHWL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359266AbiHWL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30CC844C4;
        Tue, 23 Aug 2022 02:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83286146E;
        Tue, 23 Aug 2022 09:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E7C433C1;
        Tue, 23 Aug 2022 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247244;
        bh=fy9Hbiarz6gfSjxp30zSLiolvV9NwPqMSdgxPIu22Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QupQEscY90MmE3zSGsSq54TdzggXwFSXQyfHMTtgZk8GrHdW3p1BvgqJLTF0V2ccF
         MC4FR1inkjUdtpgxjyTdylE4bNvPccc7/HocMGXdhQHSbp6JgCbCYYjuhobGaYN76U
         4RqqnWrrtOjDlhTGaWPhR/Z1ZdkqBraKngbsCWZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.4 333/389] nios2: restarts apply only to the first sigframe we build...
Date:   Tue, 23 Aug 2022 10:26:51 +0200
Message-Id: <20220823080129.426286082@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 411a76b7219555c55867466c82d70ce928d6c9e1 upstream.

Fixes: b53e906d255d ("nios2: Signal handling support")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nios2/kernel/signal.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -261,6 +261,7 @@ static int do_signal(struct pt_regs *reg
 			regs->ea = restart_addr;
 			break;
 		}
+		regs->orig_r2 = -1;
 	}
 
 	if (get_signal(&ksig)) {


