Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Feb 2022 09:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349829AbiBCJt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiBCJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:49:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785AEC061714;
        Thu,  3 Feb 2022 01:49:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9FA791F45309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881765;
        bh=bARkQo56/z3a4a3bVjDzMfuLx9fNoMUA9cghljgNxIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MpKhToUkeJcSvFz8cPFyQ4Wt1GAorxTEX493fgXevU490mCnLvOkdLcp2uyJRs+eO
         uEWdQI9R+k++tgmZkxuu1v3IRyIKm4hzPeGY9/KuiA3RAV0iVTVads5nK6/kEDwGdT
         YWMr7pr3mdel95IoU/oN18yUrtWuNsmNGJxJll44PIX9hVA/kcj9H5dJ+KkHG4FLPS
         kKY3IxEyq79R8Wn0lvfnPpfeKDXeMvYESa/yLdt4jyZTK/eqQAu5tnTMyd/zdZ4NSm
         I3qDNf4Dmm29kl2+krXfHDCMvYw9Wr2gckPCWPjD9UXut0rP0tazQHxDAYhJwtqdf5
         OoBauzrgmiUtA==
Message-ID: <1496895b-2f50-d52a-293e-cac81928056c@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 23/31] clk: mediatek: mux: Reverse check for existing
 clk to reduce nesting level
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-24-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-24-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> The clk registration code here currently does:
> 
>      if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
>              ... do clk registration ...
>      }
> 
> This extra level of nesting wastes screen real estate.
> 
> Reduce the nesting level by reversing the conditional shown above.
> Other than that, functionality is not changed.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

