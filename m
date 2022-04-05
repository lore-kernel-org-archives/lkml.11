Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34998C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588693AbiDFARA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbiDEKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:22:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94164B2478;
        Tue,  5 Apr 2022 03:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4397AB81C8B;
        Tue,  5 Apr 2022 10:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCA1C385A3;
        Tue,  5 Apr 2022 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153166;
        bh=vCNxLByh22qWpvDtzrk7nKcRMnmgzftlBFDb7fx5dWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUwiV5xyHTAkVuB5Q3pq6nFnxuRhdmpAyZ9w2ffxMN4yHVmsl0k2Jn2NUI8+w25ig
         YghWYKtbolUGS/+EMui35oIlWHXEL2KuTJxikJU5IEQoBiyEPW/1z4eppG5K2S3OZv
         O/i6VZt6PEv/o7TOZHwEtEQYUvnb6rNXUdqhOgQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.10 118/599] xtensa: fix stop_machine_cpuslocked call in patch_text
Date:   Tue,  5 Apr 2022 09:26:52 +0200
Message-Id: <20220405070302.351684079@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit f406f2d03e07afc199dd8cf501f361dde6be8a69 upstream.

patch_text must invoke patch_text_stop_machine on all online CPUs, but
it calls stop_machine_cpuslocked with NULL cpumask. As a result only one
CPU runs patch_text_stop_machine potentially leaving stale icache
entries on other CPUs. Fix that by calling stop_machine_cpuslocked with
cpu_online_mask as the last argument.

Cc: stable@vger.kernel.org
Fixes: 64711f9a47d4 ("xtensa: implement jump_label support")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/kernel/jump_label.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/kernel/jump_label.c
+++ b/arch/xtensa/kernel/jump_label.c
@@ -61,7 +61,7 @@ static void patch_text(unsigned long add
 			.data = data,
 		};
 		stop_machine_cpuslocked(patch_text_stop_machine,
-					&patch, NULL);
+					&patch, cpu_online_mask);
 	} else {
 		unsigned long flags;
 


