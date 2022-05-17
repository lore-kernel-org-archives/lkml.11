Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102EC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 13:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbiEQNg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348152AbiEQNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B15DB96
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652794572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5P5WzWojyMXlDWaDvwnnFONKEvLDJzZaE27j1zka+wM=;
        b=KT1lYCdQJOkk1gHVxfTFH1Ag6Fdxv7jkFvs6cinNeKxpxwhwzn/O+/X8ks7hoEYDkFqDgI
        OZUKLeqaGERZWwBkp4IKfcljNisdmjmrc9XO9AgCKXv0Q0w67NUtrVT8WAFTLZrauZeyrj
        hETdw9qJYdBocv79an78Ty6E+UwjqPU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-ng0nEt7xMDK0hIozOOMOzQ-1; Tue, 17 May 2022 09:36:04 -0400
X-MC-Unique: ng0nEt7xMDK0hIozOOMOzQ-1
Received: by mail-qt1-f200.google.com with SMTP id f12-20020a05622a1a0c00b002f3b5acc2e7so13849856qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5P5WzWojyMXlDWaDvwnnFONKEvLDJzZaE27j1zka+wM=;
        b=G6XaOVAgRDPH49mGWN21tlK/L2LYH2KfKhW+AHMEJflZ9LMjJucQSBOKiYXTNVXriR
         FumLdCxHqq9tOC0YwsO0pZujEBR9oASBhrBUDznr7Dz69V14GeuoA9yYbsoeckvjXA39
         m6DgO04CrqZA10hYvPyt5afTDnmdedxdjybLS8+Wc2G06u9fWEGSgwrRF4/2eOZKYriJ
         34AjjVaH4edj8H+dwE4cmJJBv/c2CMmdfjmfv4P0VX3ZJnaJADmHGRa3736fKwPGnBCm
         J55hIwciOi7jabFLSd+O8RjgbiHqsE+N27PnGsoEEkZ1cyqPkt9YkUlCxe7rFdeAaHCN
         wSBg==
X-Gm-Message-State: AOAM5335hBwhGK9LWTEk+0gjnkSkSEKzKqX1WRTng30ZhY1rjb2Qd/XT
        YpOLGxWrm+4EE/9bSlUOIVC6/BJA9c8U++TcahkfvTLRoHEcwsFZekm4Fa/g/tj3uHp8h42pgE+
        uKvRSALRi3H4PvT8iWU2idvfQ
X-Received: by 2002:a05:6214:29e9:b0:45a:c341:baaf with SMTP id jv9-20020a05621429e900b0045ac341baafmr19881082qvb.77.1652794563776;
        Tue, 17 May 2022 06:36:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEdc5eDHOjlBpS8FPC+AOzBoHQp0zSLnPR5J0xOEFYvmjviuh3P28nkrVwstGyAbD+Qf1rPg==
X-Received: by 2002:a05:6214:29e9:b0:45a:c341:baaf with SMTP id jv9-20020a05621429e900b0045ac341baafmr19881031qvb.77.1652794563247;
        Tue, 17 May 2022 06:36:03 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id x2-20020a376302000000b0069fc13ce1e8sm7575349qkb.25.2022.05.17.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:36:02 -0700 (PDT)
Date:   Tue, 17 May 2022 09:36:01 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: qcom-qmp: Add SC8280XP USB3 UNI phy
Message-ID: <YoOkwZAH7EM9AUop@xps13>
References: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
 <20220513225348.1671639-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513225348.1671639-4-bjorn.andersson@linaro.org>
User-Agent: Mutt/2.2.1 (2022-02-19)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:53:48PM -0700, Bjorn Andersson wrote:
> The SC8280XP platform has two instances of the 5nm USB3 UNI phy attached
> to the multi-port USB controller, add definition for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I verified that these match what's in the downstream sources for the
sa8540p.

Reviewed-by: Brian Masney <bmasney@redhat.com>

