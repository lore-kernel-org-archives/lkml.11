Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E57EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jan 2022 10:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiAMKDU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:03:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiAMKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:03:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1C4741F4585C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642068193;
        bh=z6Fpv+ojSruJtKvGcPH7kOYeobLJWz00NiG70Q+tJBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H6rciqMQ+aIyqB7yph7vl+C/moxOxZT3EWo6xzZ1kyXmcfvIHLOexyV/uy7GKUJ0l
         uN3lMkyv6piipk/ZpY7mpYjDIlGujep1CcLX4qFrN7cPyvTBN+8W8VZRY7PmR1iXfn
         K2r9BAo/1qJTHIz0KyV8RUKt+6lwbfe3OSgHOJg9gkDrmXQeYnEhpGo2dcR2tQCXYK
         +xQNuvxohNSN84bhfQ1JYJ9Gyjc4QnxEqEIqBgIQvgWSACN3UBjKVErUMjYvPHFEc+
         T/gLU5fSYLcvGxPM5Rh6u/LjesuDOnvZvnkns5Tm4YKreimqKWD0xbVoSjEzCHNQ/9
         K2guIAsxypswQ==
Subject: Re: [PATCH v4 1/5] arm64: dts: mediatek: Correct uart clock of MT8192
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220113065822.11809-1-allen-kh.cheng@mediatek.com>
 <20220113065822.11809-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3eeea0ce-0551-1186-7011-9bda27d62b98@collabora.com>
Date:   Thu, 13 Jan 2022 11:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113065822.11809-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 07:58, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> When the initial devicetree for mt8192 was added in 48489980e27e ("arm64:
> dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"), the
> clock driver for mt8192 was not yet upstream, so the clock property nodes
> were set to the clk26m clock as a placeholder.
> 
> Given that the clock driver has since been added through 710573dee31b ("clk:
> mediatek: Add MT8192 basic clocks support"), as well as its dt-bindings
> through f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks") and
> devicetree nodes through 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192
> clock controllers"), fix the uart clock property to point to the actual
> clock.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

