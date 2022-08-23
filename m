Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D96AC32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiHWIRf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiHWILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E086B64F;
        Tue, 23 Aug 2022 01:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CA8611A8;
        Tue, 23 Aug 2022 08:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5ADC433C1;
        Tue, 23 Aug 2022 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242131;
        bh=sVRq6GYr36EyWxxaM/Q4HPEpxh0pt9Zt099fApkr6Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOvHfCOZ84H8McuFHwspe35LOILoIXGLB1RzvExAPda9fMG7QGLy8waBbjSjX3r5S
         2dNy2p91Lib2DqpG5GyVjkU0OfrkS1vJL1zFEc23+O1zJr3nB3UOx8n6/Xjx2Dh1Y9
         TwTqOVRwvoIopO7sxZJZaxV7dUI2Uhal+y+qd8hA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [PATCH 4.9 023/101] random: only call boot_init_stack_canary() once
Date:   Tue, 23 Aug 2022 10:02:56 +0200
Message-Id: <20220823080035.453767597@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>

In commit 166a592cad36 ("random: move rand_initialize() earlier") the
boot_init_stack_canary() call was added after the new random_init()
call.

However, the upstream commit d55535232c3d ("random: move
rand_initialize() earlier") also included removing the earlier call to
boot_init_stack_canary(), making sure this call is done after
random_init().

Hence fix what I assume is a wrong merge conflict resolution on the
linux-4.9.y stable branch.

Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/main.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/init/main.c
+++ b/init/main.c
@@ -500,13 +500,6 @@ asmlinkage __visible void __init start_k
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
-	/*
-	 * Set up the the initial canary and entropy after arch
-	 * and after adding latent and command line entropy.
-	 */
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
-	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();


