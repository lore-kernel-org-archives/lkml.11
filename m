Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1BC4707E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349209AbiDNOTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245722AbiDNNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C8A7757;
        Thu, 14 Apr 2022 06:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DDEB82968;
        Thu, 14 Apr 2022 13:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E0C385A1;
        Thu, 14 Apr 2022 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943233;
        bh=vCNxLByh22qWpvDtzrk7nKcRMnmgzftlBFDb7fx5dWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdJ4E48nqz83iUXm5y5hC50Dixoncl8bE+eGp8GRcvdS63oD3KXTU/kqxOiYVoIde
         Qtp6Yk3eYaVX+6VvdR45qZd5Ddm3Tb12vyNIi01PekyQU+94IbbEZ9OWoIs6Kq7g6P
         jGAjwv2vbm5LROme2tQ0dNsFwQygwEXdUDKUVVAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.4 081/475] xtensa: fix stop_machine_cpuslocked call in patch_text
Date:   Thu, 14 Apr 2022 15:07:46 +0200
Message-Id: <20220414110857.422252189@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
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
 


