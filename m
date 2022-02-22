Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1BC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 19:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiBVTZB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBVTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:25:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFBD5047B;
        Tue, 22 Feb 2022 11:24:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C251A1F438A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645557873;
        bh=84ngh8hfVnYOA1iVw38mIlicE6d774xxlmyzKJEKbDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jug73saHREsfKSjJcnkKSo4QrKWe4axGeTVYiTEEl12Nxrh/3/bsEGeIvozu1ral5
         bjqrtbTZMMwa3pE8MsHc7WzpEYBwMjZHPu4Lx/jggVqfJMsdT72lns83ZNbdctPVU9
         6kEndgG6gXxuFrf4sLvPK1OD+T0ma/e/f+rWVIqOOZSi3xFtS9FWTXhxYcLmzQP5dQ
         HLvoYk0RUsEKUXt1WBj9x2gGhjtPsCHj0DECiwVGRL7ZqirNaAmmSIQIJR+OY3dcwn
         M4wovVH5xUyPlXHDsn+vIkQPN0v3S92gvHDZYUFVRtUO05PRwWRNB3kGqUmFk3//IK
         ya8iISu+grbHg==
Date:   Tue, 22 Feb 2022 14:24:28 -0500
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
Subject: Re: [PATCH v2 02/23] arm64: dts: mt8192: Add pwrap node
Message-ID: <20220222192428.i7sjiim2uwrqvfng@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218091633.9368-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:12PM +0800, Allen-KH Cheng wrote:
> Add pwrap node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
