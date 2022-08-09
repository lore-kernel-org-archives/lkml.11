Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AF9C25B07
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiHINxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiHINxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:53:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D02610;
        Tue,  9 Aug 2022 06:53:20 -0700 (PDT)
Received: from notapiano (unknown [193.27.14.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31A1C6601C45;
        Tue,  9 Aug 2022 14:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660053198;
        bh=R+CpuZN1Sl+R1CObLrG1wLITHiTzHmjmpta/SIREkdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjuY2JQzbM0PFwmAXUkG2NewMPwh5uPBzPQkoYv8b+NViFKYoRaSGYgXA6YSAWYna
         qSBCjU78IGhJ0uGfuZn1Dm3GK3sBSeTGvJn1h4XdjaUwFgk2W+FEOhGkRDDJFRzjOJ
         h6KRVfb+d4ZURdxwDr4dcpUa4or57PdiFRkAIwdaxAEEn9Px2t9oVIl/E5wlAs04f8
         X9cns2SgL1slzGdaZ5yS6uInTQxTVkc37bwEle4BoVpSUOeSYyFPhU4OJDaxvVrrlC
         7CWGQFRiCPv/rrgLzG7f46/tSSyyk5QXckkaePiEdtklThsMY+ItVw04TaYHAG3H3X
         XVOk1qLihA2aA==
Date:   Tue, 9 Aug 2022 09:53:12 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Message-ID: <20220809135312.hadcs7ti2cgyyuez@notapiano>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-3-tinghan.shen@mediatek.com>
 <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
 <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:01:10PM +0800, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-08-04 at 17:12 +0200, Krzysztof Kozlowski wrote:
> > On 04/08/2022 04:15, Tinghan Shen wrote:
> > > 
> > > It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> > > matches the 'else' conditions for gen2 HW without gals.
> > > 
> > > Rewrite the 'else' condition to specifically identify the compatibles
> > > that utilizing gen2 HW without gals.
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno
> > >  <angelogioacchino.delregno@collabora.com>
> > 
> > Unfortunately, your patches got corrupted.
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> Do you mean rebase to the latest linux-next?
> I'll rebase in the next version, thanks!

Hi TingHan,

the issue is that some line wrapping happened on your patches, which broke tags
and also the diffs themselves (it's very obvious on patch 3). So you need to
sort out your setup so that no longer happens, and resend the patch.

Thanks,
Nícolas
