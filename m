Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CFC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiF0L3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiF0L2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:28:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E879FFA;
        Mon, 27 Jun 2022 04:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F32D4B81117;
        Mon, 27 Jun 2022 11:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55814C3411D;
        Mon, 27 Jun 2022 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329235;
        bh=ysNOEvu3zGd1TifXXdMtyPRCM21reTJXO7MAoKCElac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mi6lM7Fxq6tOPemc0O24h5TmdkhfNCfRJKMwjvbb0RJBgJrYhK6iixV61dtKdV1mi
         hGMdfyI/A6WKYbL/5UpawEg+xfQm39pqO43ii305aM4vO4/NVYYKgZHuXtowxEeYSg
         3QDgtuKtFJDBD0ozuuNrnH2jG093Ze3YFQ1YoUV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.10 096/102] ARM: Fix refcount leak in axxia_boot_secondary
Date:   Mon, 27 Jun 2022 13:21:47 +0200
Message-Id: <20220627111936.314856945@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111933.455024953@linuxfoundation.org>
References: <20220627111933.455024953@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit 7c7ff68daa93d8c4cdea482da4f2429c0398fcde upstream.

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 1d22924e1c4e ("ARM: Add platform support for LSI AXM55xx SoC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220601090548.47616-1-linmq006@gmail.com'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-axxia/platsmp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -39,6 +39,7 @@ static int axxia_boot_secondary(unsigned
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 


