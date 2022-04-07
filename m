Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 08:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiDGIUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbiDGIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CA4D21E503
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649319513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jW/rk7FENs40EnB0uCA1bBOqTjnDJxLTwFnAX1mGka8=;
        b=hw+2QpvcYeynyKijXuBGS4oZeUjC2PVRxAdT1LuEe17Tvbmwg2gST0YST5qWyo8KN6jB9A
        YlP1d68XPbEnYM5Sz4Y8XKoMewjyGFsdAPkIUeMKkQByr1DeyHy5iS2kvKv/8YmboRzzME
        1tA6bEiuKGulKRkJ8vIstfkxRWmtuZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-1XX1et3ON6mRPYQlCJU-zg-1; Thu, 07 Apr 2022 04:18:32 -0400
X-MC-Unique: 1XX1et3ON6mRPYQlCJU-zg-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so2642661wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jW/rk7FENs40EnB0uCA1bBOqTjnDJxLTwFnAX1mGka8=;
        b=svgPz6uLZ1u7+Km8VHfA5WEcEr+b/6QQvCq1Gplixl8pO1+kmKWyvAokVeKek6/npW
         QmQB4OY29NfbO2gxuHTDEAbhKYN39ooEYKXelaIGHPR2ARevTqwLrXT1W800nCpWx1Gq
         H3k4ri9O6Y68SYcmAIZVa0zUepQFEh4SxFlvfaHlSgboU/Pc+9MmwSKkEx55A8O1UAKM
         CL+L2Ppojzf9xq2dZfC/iDRvyEeMnqWNYD1oj3E72Fz+z5Eo3bIeY8OsGAfXpPWYTJJT
         1mqST5KbZakttYh9Q4COtPeb1sl6qLxYk3G7JH+AvxR3U2MyVMv9LqPPXWYuMJcTNvo+
         nfbg==
X-Gm-Message-State: AOAM530ysCJd5pD39hEuiZK0jf9MIRlLc1E8BdzY5PRU28nW4Jx52FXR
        wL/fiWVTs+ulosy2JbLgM/hN2QaKNqcWBqAZiInewh/mSth0MKIfQs3UUZYXw/EwzywiFyHXsaX
        bZH+4EPtNMr/0wBtZ9MuBg9bT
X-Received: by 2002:a5d:6812:0:b0:203:f854:c380 with SMTP id w18-20020a5d6812000000b00203f854c380mr9677203wru.235.1649319511259;
        Thu, 07 Apr 2022 01:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxClxX14TbXWBIOJlDwZ06lVilSCrfAbdShQ6nkODxUZiE+GQP/JhL48g6k/Zr7Z+5NJx1VgQ==
X-Received: by 2002:a5d:6812:0:b0:203:f854:c380 with SMTP id w18-20020a5d6812000000b00203f854c380mr9677191wru.235.1649319511074;
        Thu, 07 Apr 2022 01:18:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm20316538wry.53.2022.04.07.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:18:30 -0700 (PDT)
Message-ID: <62711467c3990d38ed8a11bf1c7c2594e8e1b436.camel@redhat.com>
Subject: Re: [PATCH 0/2] dt-bindings: net: Fix ave descriptions
From:   Paolo Abeni <pabeni@redhat.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Date:   Thu, 07 Apr 2022 10:18:29 +0200
In-Reply-To: <1649145181-30001-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1649145181-30001-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2022-04-05 at 16:52 +0900, Kunihiko Hayashi wrote:
> This series fixes dt-schema descriptions for ave4 controller.
> 
> Kunihiko Hayashi (2):
>   dt-bindings: net: ave: Clean up clocks, resets, and their names using
>     compatible string
>   dt-bindings: net: ave: Use unevaluatedProperties
> 
>  .../bindings/net/socionext,uniphier-ave4.yaml | 57 +++++++++++++------
>  1 file changed, 39 insertions(+), 18 deletions(-)

@Rob: since you acked this series, I guess you prefer/except this will
go via net net-next tree, is that correct?

Thanks!

Paolo

