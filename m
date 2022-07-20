Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF1C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 13:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiGTNMZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiGTNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:12:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A25B7AD;
        Wed, 20 Jul 2022 06:12:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54BFB6601A88;
        Wed, 20 Jul 2022 14:12:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658322733;
        bh=cy9CGHgqudLNo61Fmsl3sxpvn+cV59KH4fqka9jc6+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FI84RkOq+tEMic+IJkcaL9HfaYnzxa16LAjdkHogv5GYzCd3UbctCGjlyAp3PU49K
         EA4L7iGTZrYx6yl4dO+WrYL5kWKdwpxXqIiJJF8x73Sq27RAwAqOYu5Qp0VTSVCbem
         TLeJbB86aFjlcejONbQXqr3+f3p5JatKPcDOlfthTCcVU/eGlhteWOO8CnikoPUaql
         DqsHlvkACls3iIMz5Tq8p72OeFi8CmQl7ybAUX8G1FH7bPQrwA0LyynCsb/vA+cTpz
         W/oa0mWLIcN7Gdapwf/wvnssu2OP6X0prtirnQDeIjeNX0Oe18ofhjCXcqfakpL90P
         YYj4dqhMU4m/w==
Message-ID: <17b679a2-1248-c9a3-a372-f15f6350e662@collabora.com>
Date:   Wed, 20 Jul 2022 15:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/4] arm64: dts: mediatek: Fix the watchdog node name
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
 <20220720125015.13797-5-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720125015.13797-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/22 14:50, Allen-KH Cheng ha scritto:
> The proper name is 'watchdog', not 'toprgu'.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

