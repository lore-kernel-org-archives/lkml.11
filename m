Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14155C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiBVTbl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiBVTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:31:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367CBF4E;
        Tue, 22 Feb 2022 11:31:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 94AFF1F42C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645558270;
        bh=vZziczXassul2CymxgXhkwNg2UBW/i5hySVH6iKoSkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X87BBKUrjMdOyVJxoPd+Sq7cUKuydQJm41Lm+Z546naJqX88X56ptY+ktWPha0r34
         9o8ksTzO0Ra25o4ZDf0EKdbDCKPqe2Qye15At2inxVXZ7fzr6Ku5u219fzWN12WGJO
         v0LNQv9flc2atvScVzmq4jYULiQIeH2dHfJ/VHJtEB0DAQ3dAcG4cQAkBeDD0mFSGC
         6boEV6nUNW6xHNgZsAyiX4yUVlSUdnrlEsq4rWq495jhQqw86D8cBKvEMwjfYR+d2o
         +aZbmBQ6xSD+skSUTYmCGBXkAnGEQiwTpJz+AZ7aFo7iJm4Zt12KxC9/d34eYRTJaE
         wMF8u5Tkmv8fw==
Date:   Tue, 22 Feb 2022 14:31:05 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 03/23] arm64: dts: mt8192: Add spmi node
Message-ID: <20220222193105.zw2e3bhpfymk4kv2@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218091633.9368-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:13PM +0800, Allen-KH Cheng wrote:
> Add spmi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
