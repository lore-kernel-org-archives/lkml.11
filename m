Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 13:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiFBNEu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiFBNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:04:49 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E31E562A;
        Thu,  2 Jun 2022 06:04:47 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id p129so1784999oig.3;
        Thu, 02 Jun 2022 06:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUqVqrJP8hpf0KLUEUTHZhE9DaMt/u7RwjOLvmeIQa4=;
        b=Pnbg8vGmvzVRkC4QBbxdVwNMaQzNRdA4ozUl0rOMAqgkoAfJbpJm0mIDuvbgfPr11Z
         CcaxSrWEEw0Ng8iJElLnvAsHo8cSkaLBrIj6P7ecW/pmO7HyM9q164LVBimOnFikRuCw
         5jfTUpRqowFpvUnnTUzDOAFtVsNkmXzThW6ouEBULp7UdgjjlX6denyvW9J2maoTWi5E
         tw4dYQ58s/+Cct+JVXvIE9PepxUeGGNASQWNwfWjVMU038FQpprzdzgb2r63bFkrmtRo
         8vm8Vcjnh1KYvpDi4WCPXTGGYxcQn5UCR+flYC77+/UYCVftzJXwPWQ5Bk8SWd0BnFAy
         tZ5w==
X-Gm-Message-State: AOAM530suulfv8vT6U0LjGpn6+n4IVIZ7UCHxBq5xzFMKU+r9XbfLxQG
        AJLrQQ1+nWXpgH2T560nOw==
X-Google-Smtp-Source: ABdhPJzCakeKGnP2z4QHnJMY/hAq5LuT05CQuOiettY954ZRY2sgkP4PmgjaCJ5DPW8q6LFib5tLvQ==
X-Received: by 2002:a05:6808:1407:b0:32e:1ad1:2d4 with SMTP id w7-20020a056808140700b0032e1ad102d4mr5048424oiv.235.1654175086977;
        Thu, 02 Jun 2022 06:04:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d6-20020a05680813c600b0032bbcbd59b4sm2338696oiw.17.2022.06.02.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:04:46 -0700 (PDT)
Received: (nullmailer pid 2106788 invoked by uid 1000);
        Thu, 02 Jun 2022 13:04:45 -0000
Date:   Thu, 2 Jun 2022 08:04:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 2/4] dt-bindings: usb: mtu3: add support 'resets' property
Message-ID: <20220602130445.GA2106738-robh@kernel.org>
References: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
 <20220523090449.14430-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523090449.14430-2-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 17:04:47 +0800, Chunfeng Yun wrote:
> Add 'resets' property to support IP reset usually by top pericfg.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
