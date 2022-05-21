Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E8C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354936AbiEUNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiEUNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:25:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F7606E2;
        Sat, 21 May 2022 06:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 253D9B80108;
        Sat, 21 May 2022 13:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4114C385A9;
        Sat, 21 May 2022 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653139511;
        bh=TtsmzGF2DXoo2HJhpgTVn65C9PXQiFnU4QjU6HdszEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRp+L4yWy/16jwuYKsHDzlJW3T3v2wAMrT5wDYNqHirJ9svLFu+8IgVTkdyDt29NF
         /wubP5GvBW5e/t+XhRrNZ+dni5xrwGIWpmBSE2MmV3/qh0lAvGErLgF5EfSU0Z4SdY
         VKCRGzkCXx2v56DorRqHqqCQw6T0q8ujH0b/Znc0=
Date:   Sat, 21 May 2022 15:25:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Message-ID: <YojoMzjahyP+HW4m@kroah.com>
References: <20220521015613.6197-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521015613.6197-1-soumya.negi97@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:56:13PM -0700, Soumya Negi wrote:
> Converts .txt documentation file to ReST format(.rst).
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst

That did not "convert" it merely added the new file.  Where was the old
file?

And does this get added to the build somehow?

thanks,

greg k-h
