Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE623C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 20:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiHWUgd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiHWUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:36:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C9F0B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:18:08 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C25AA6601E70;
        Tue, 23 Aug 2022 21:18:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661285887;
        bh=3HtXjX4gyHmU0D4ZFCriKrikrXvs5wvAt9U4bZ/suVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezfM/oUp6/AuRLjhow5JNV5fK54K3j1G+aWnWYXn4cTK1ZLqKWrWn1aEleUvpwpSU
         dNfQq02+hg2K7p9NE0q6DJsPVeFzDAMc5XvjsNjQLg12J7T/78CBUrg9/LccOV1tvf
         jFzNLcpOXWzmYU2noLOEaw3+j2DWRQdSZDhHDNcXdDwuT0s75Hg22SQ/IeU/Hb9vWh
         ymVIbv2HxqnldjJipD3KwxkJ4+mRZoN7MejPeGbIkWuZFNAWyhcRs0d2WeyDxEQmZ7
         WyXAJcpMygBHOpodZkF9MZe5IB4XrL/I2Ai5D2NBzG5Jnq9FQtG1IB6ajrxb7Jas7G
         E2AH0/6f3Gfzw==
Date:   Tue, 23 Aug 2022 16:17:59 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     xinlei.lee@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3,1/2] soc: mediatek: Add mmsys func to adapt to dpi
 output for MT8186
Message-ID: <20220823201758.ffbgb5t5odoicgir@notapiano>
References: <1661236702-30682-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661236702-30682-1-git-send-email-xinlei.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 02:38:22PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add mmsys function to manipulate dpi output format configuration for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
