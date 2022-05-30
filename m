Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 07:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiE3HGw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 03:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiE3HGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:06:45 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46E1007;
        Mon, 30 May 2022 00:06:43 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7161E1C0B8F; Mon, 30 May 2022 09:06:42 +0200 (CEST)
Date:   Mon, 30 May 2022 09:06:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA
 definition for mt8195
Message-ID: <20220530070641.GE1363@bug>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509044302.27878-2-rex-bc.chen@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-05-09 12:43:00, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Your signoff will be needed, too.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
