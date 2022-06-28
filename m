Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB390C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiF1WsM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiF1WsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:48:11 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56747B49B;
        Tue, 28 Jun 2022 15:48:10 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id u20so14330724iob.8;
        Tue, 28 Jun 2022 15:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufBPgGQwDJaGgA8RtBM50f69synxCdmQIvVZ/6riFl0=;
        b=P0smpRxacksOlrYoTvVU59TI0OOOcFNuVwI1T5xGHy+5matO50EAT1baUxrnDQMfBT
         Qn2rZXkB94O9viqlU5psrw4QVoAav5AjlhHFXrhXtPfDDsg0/POOg8e6WzVWf7I0Jpw3
         UtOX0vGudP6a+MNEIAz+qvIlWvbU/KvMfmtcL9l8EEnJULy03B51Jhlbo0tiA30IgMK+
         Cmq/YBqFxyvPf/lFLkg/5uNV7HspNSfH88jkFSCL4LMarimFIyaHHi/G8Fg0ijJ78kuD
         qyCQtljCRmU7U/NkcVfguAWTQojYyWvCCWyLhCoa4YMCrdjsIuWRsxqZHO54S4dQhW2j
         iccA==
X-Gm-Message-State: AJIora/nTvlCeA8zaPXnPjzu+3Flpnr9FJDRjxdOXYL6ydKur9N0+vRK
        2ZuEQnL9TQOSW7124QcCkw==
X-Google-Smtp-Source: AGRyM1tE0nv/i8Pu8TcYrZ29WqQfYJN8oMTA/D2QESGtqHghxVnLHjqVBQUUO6QJS/+4zgOgE7CRgg==
X-Received: by 2002:a05:6638:2507:b0:33c:cced:93b3 with SMTP id v7-20020a056638250700b0033ccced93b3mr264098jat.310.1656456489566;
        Tue, 28 Jun 2022 15:48:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 13-20020a920d0d000000b002d1ed1f6082sm6223491iln.44.2022.06.28.15.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:48:09 -0700 (PDT)
Received: (nullmailer pid 1114458 invoked by uid 1000);
        Tue, 28 Jun 2022 22:48:07 -0000
Date:   Tue, 28 Jun 2022 16:48:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: nfc: nxp,nci: drop Charles Gorand's mail
Message-ID: <20220628224807.GE963202-robh@kernel.org>
References: <20220628070959.187734-1-michael@walle.cc>
 <20220628182635.GA748152-robh@kernel.org>
 <20220628120901.693b1470@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628120901.693b1470@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:09:01PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Jun 2022 12:26:35 -0600 Rob Herring wrote:
> > On Tue, 28 Jun 2022 09:09:59 +0200, Michael Walle wrote:
> > > Mails to Charles get an auto reply, that he is no longer working at
> > > Eff'Innov technologies. Remove the entry.
> > > 
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > >  Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 -
> > >  1 file changed, 1 deletion(-)
> > >   
> > 
> > Applied, thanks!
> 
> I thought you said you prefer binding changes to go thru relevant
> trees. Not that I care which way the default is but let's stick 
> to one.

I did, but wasn't sure on the NFC stuff and this one was trivial.

Rob
