Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E052C25B08
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 19:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiHOTFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 15:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245566AbiHOTCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:02:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D586933436;
        Mon, 15 Aug 2022 11:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A80EB81081;
        Mon, 15 Aug 2022 18:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1065C433C1;
        Mon, 15 Aug 2022 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660588408;
        bh=GOWshVnBwy6EwloCgplMH55chcLT2EZdBYc4L1saBCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjybJC5claaT44IqMOsmFiw5kQR+Tb81WCaWUx57Uk1qmYruyQh0CjRZ7ydR1pE+k
         T12qReVfcO0I7TQ/gn6UMJ9ZoxplUiRXOkY/FytSRHDHgldZ3kt9mmMM5G9JjNGCOz
         JGJKjQvwtQNPL7DmlVYvqrL5ZhvmvqX9qw//dDKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang He <windhl@126.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 363/779] i2c: mux-gpmux: Add of_node_put() when breaking out of loop
Date:   Mon, 15 Aug 2022 20:00:07 +0200
Message-Id: <20220815180352.756604330@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang He <windhl@126.com>

[ Upstream commit 6435319c34704994e19b0767f6a4e6f37439867b ]

In i2c_mux_probe(), we should call of_node_put() when breaking out
of for_each_child_of_node() which will automatically increase and
decrease the refcount.

Fixes: ac8498f0ce53 ("i2c: i2c-mux-gpmux: new driver")
Signed-off-by: Liang He <windhl@126.com>
Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-mux-gpmux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index d3acd8d66c32..33024acaac02 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -134,6 +134,7 @@ static int i2c_mux_probe(struct platform_device *pdev)
 	return 0;
 
 err_children:
+	of_node_put(child);
 	i2c_mux_del_adapters(muxc);
 err_parent:
 	i2c_put_adapter(parent);
-- 
2.35.1



