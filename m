Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 07:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiCXHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiCXHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:47:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC9972D5;
        Thu, 24 Mar 2022 00:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EECCB82239;
        Thu, 24 Mar 2022 07:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDB3C340EC;
        Thu, 24 Mar 2022 07:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648107933;
        bh=p8qcVNPM2qOW9EQx6XQFqzBj4GCexX5/KhXigTDY4CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkCctxK1ampcX4CHpJBsPTacJaKiSiD9/RE/8CD2xKcHSV/q0mM5WmjaEUhZc34qZ
         ZCNKp0AvyjR1swsxhK1oo+cKNBSfvyoeptu2eWERG+T3W0+lF8HxXxjWgHC5czisUK
         +VT/r0C2HyXF4wZwjyplE/43W/5OFZ6WYDogbHFQ+DathtKjpeSv0sfmBdV5De6471
         UTNm9aNRn6LEumumovVAKNSF83sQn5uUJUVjR+6ucDrdQvCQZeJmM8/WsmmonQ2aze
         U966/qim2RMx/7+bnPat763Lx5fHgddm4MsFNLhdQTll/Yk6c+Dex+W5SZDW2upnKh
         jSGpRXYWBE81A==
Date:   Thu, 24 Mar 2022 15:45:29 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        yc.hung@mediatek.com
Subject: Re: [PATCH v4 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
Message-ID: <Yjwhmacdw+birt0/@google.com>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-6-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324053851.27350-6-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:38:50PM +0800, Trevor Wu wrote:
> This patch adds support for mt8195 board with mt6359, max98390 and
> rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
