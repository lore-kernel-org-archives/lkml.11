Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E2EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 13:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiF3NyN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiF3Nwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592534664;
        Thu, 30 Jun 2022 06:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D3761FD8;
        Thu, 30 Jun 2022 13:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C33C34115;
        Thu, 30 Jun 2022 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656597000;
        bh=l+0t1T7UVgnnl52KigGaMI+Ya57FIMlUgLltqt/jz/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaGTonxdISR/BsXGEERGT+72jMbHzphrnNVCi6NXo8nGGUFsPHZ8542BrOKijNopB
         Q9qVlIBU+0wTnfi+OY0vTUnw6JEVQRV9111uDc538inHyxZ2fytl+9EC57G3ylzuyu
         BtF++FGnsSskJu84cmQjg/wAuuSULSbNBFpmF9gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 27/35] ARM: Fix refcount leak in axxia_boot_secondary
Date:   Thu, 30 Jun 2022 15:46:38 +0200
Message-Id: <20220630133233.237132772@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630133232.433955678@linuxfoundation.org>
References: <20220630133232.433955678@linuxfoundation.org>
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
@@ -42,6 +42,7 @@ static int axxia_boot_secondary(unsigned
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 


