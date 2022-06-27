Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A219DC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiF0LpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiF0Lmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:42:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26270F4A;
        Mon, 27 Jun 2022 04:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0162B8111B;
        Mon, 27 Jun 2022 11:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3D3C3411D;
        Mon, 27 Jun 2022 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329853;
        bh=WZXy+Bd4DgG1VVzSNOzT8zUIRZ/5VvEGPPSlCWy6ceA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeGUkEdQbOst5bCgmtlvRiGj9fCw8F+5fNG13XpI5zmNAi1ohY8nxIP0otnAHUrSG
         1eylxWu6O/fRRb3UsqfCFK/XswWqJ93JBYXbzN68muFwsl3u0A9AD33+66GXpyBHHj
         4CqoY6eqseHgopZX+cxkRfnwLUnOqQ/WGhIHIfaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5.15 124/135] ARM: exynos: Fix refcount leak in exynos_map_pmu
Date:   Mon, 27 Jun 2022 13:22:11 +0200
Message-Id: <20220627111941.752736247@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111938.151743692@linuxfoundation.org>
References: <20220627111938.151743692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit c4c79525042a4a7df96b73477feaf232fe44ae81 upstream.

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() checks null pointer.

Fixes: fce9e5bb2526 ("ARM: EXYNOS: Add support for mapping PMU base address via DT")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220523145513.12341-1-linmq006@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-exynos/exynos.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -149,6 +149,7 @@ static void exynos_map_pmu(void)
 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 }
 
 static void __init exynos_init_irq(void)


