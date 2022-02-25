Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E547C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 23:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiBYXHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBYXHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:07:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1652177F0;
        Fri, 25 Feb 2022 15:06:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B78DB1F46802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645830400;
        bh=58x7jynVJtBpgB4TfuRcpKnHM5IK4vhp6DiWw95AlxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4v22sPr+SGzmsKBtZMST66vqQ51BjGlJy8G8Wr2TJG0kiOPLdZXhKc9ssdCgV3H1
         /BKf7fXASO8Shq97WxREXdvmy2wn7ytKqykGlpQ19eXgcHstqyHyC7zZG2m3TmA8Ap
         tjAqPMnNM6iv59cUoFG21lXC2cIyJ5YZFcoKySholAm/voWW+ErG4hGEo3wQsIq3RU
         e8YUNOL1ttw7/h7ZF8DjQW8hmc1Vxg+YjVXogpLf9f9XxtiBz7TucdogJB0H13hFiQ
         xRfDuLIvkuKUnL9XJPXQ9pAskskiPTMFZ1/ns5nmbIRUXPl54Xe4oOjYHqWRP9veiB
         U2ziB7iFOPIaA==
Date:   Fri, 25 Feb 2022 18:06:34 -0500
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
        Ryder Lee <ryder.lee@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 15/23] arm64: dts: mt8192: Add m4u and smi nodes
Message-ID: <20220225230634.bqmezldkzraa6v6o@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

actually there's one other thing, please see below.

On Fri, Feb 18, 2022 at 05:16:25PM +0800, Allen-KH Cheng wrote:
> +		iommu0: m4u@1401d000 {
> +			compatible = "mediatek,mt8192-m4u";
> +			reg = <0 0x1401d000 0 0x1000>;
> +			mediatek,larbs = <&larb0 &larb1 &larb2
> +					  &larb4 &larb5 &larb7
> +					  &larb9 &larb11 &larb13
> +					  &larb14 &larb16 &larb17
> +					  &larb18 &larb19 &larb20>;

I just sent a patch [1] fixing the formatting of the mediatek,larbs properties
on other Mediatek Devicetrees. So please do the same here so we can avoid
introducing a new warning in dtbs_check.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220225225315.80220-1-nfraprado@collabora.com/
