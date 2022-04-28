Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 00:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiD1A4D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 20:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiD1A4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04355F8DA;
        Wed, 27 Apr 2022 17:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE21B8292A;
        Thu, 28 Apr 2022 00:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2886C385AD;
        Thu, 28 Apr 2022 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651107167;
        bh=RntiTRc85eJLhPUewH4qjDve/WIYbOdE8I4/T+hgqN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pzUGQtV8izUYgoqpPEwQh/sZmA2JkvoN74k2FsWu58IEn2n+bpml6q+E8kBoM2UB9
         wV6fL2HPaBwaSXYxVRdXXbwlaABYKKuamF8Rfz8EE2mQNXkgXRNuUHsNTvXF6Xa2I9
         vOiyw+FKGMVwf7A8jbm5DQX3ONMmd46PbgVm4CWKCM4cAEN0Amxf8nXi5J4QvOAvnG
         UN/3KlBSGB7Ddu3g7sifTPvolbMVu3zG+AWAhWuDVureucM8l+kixfWHAE+ZKtdPe1
         I1XYiVmVvSEpu9Lwq+FXnX1WFsZ9Fmu2U1YCKZHNUoiYZSrOGkiTOThVPolEun4h+5
         9OPnabiW2h3Vg==
Date:   Wed, 27 Apr 2022 17:52:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <davem@davemloft.net>
Subject: Re: [PATCH -next] net: cpsw: add missing of_node_put() in
 cpsw_probe_dt()
Message-ID: <20220427175245.2311a74c@kernel.org>
In-Reply-To: <20220426124757.373587-1-yangyingliang@huawei.com>
References: <20220426124757.373587-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 20:47:57 +0800 Yang Yingliang wrote:
> Subject: [PATCH -next] net: cpsw: add missing of_node_put() in cpsw_probe_dt()

Why next? The commit under Fixes is in Linus's tree.

Please sort this out and repost.

> If devm_kcalloc() fails, 'tmp_node' should be put in cpsw_probe_dt().
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
