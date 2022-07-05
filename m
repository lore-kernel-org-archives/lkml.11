Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4F6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 05:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGEF25 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 01:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741D6F39;
        Mon,  4 Jul 2022 22:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D3AB815FE;
        Tue,  5 Jul 2022 05:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B42C341C7;
        Tue,  5 Jul 2022 05:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656998932;
        bh=DT4UIwXOPm/U5pxBn4S+Q62xBU0Dw1gcRV/ohROJwFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIUbXIvc/0tOr4blXlZxX/rWawVthHOblHaP7Oq/axisrbpj1lbnpvQpv2GZtStXJ
         Vtgxow99Nz4+79ofpONR14MArcTUlZscijXYFT1YPeFabACnXZDby47xs5E80ROCBd
         i39Jx8ieUln7fagCN+h7SBzereGX9Z7+IByitBw0kLbe7GxBtpjDIdGSHj8wtsS67Y
         Bj2sol9UnFX27NGYyDMKnbvhFvSds36CjF5bL0YeYxyor4msYfB7pA6SVM7d8qJT0+
         OELrzPGEtKg1Ei1axt6aeCUuZQ365rwpajEZxs9u0N3DCBpJSmud8QEbjNrHCbPp13
         OONr6cnxONY6g==
Date:   Tue, 5 Jul 2022 10:58:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Subject: Re: [PATCH v10 0/2] phy: mediatek: Add PCIe PHY driver
Message-ID: <YsPMD7Wj/vN3HpEf@matsya>
References: <20220617070246.20142-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617070246.20142-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-22, 15:02, Jianjun Wang wrote:
> These series patches add support for PCIe PHY driver on MediaTek chipsets.

Applied, thanks

-- 
~Vinod
