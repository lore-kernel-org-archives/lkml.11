Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 08:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbiCOIzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346236AbiCOIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:55:50 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5310615D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:54:39 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e24so27788157wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WjT/xBU7Jfr905EpqGcI41n9yUBAmerdU0vll5TSzS8=;
        b=SME3SvfglcVwcvmv8pssd956EqM96zNhSEF6CrjXkR4uQtMkDZ+ztn54P8H+2wOc5+
         nqxIqS5BSxT0dtXBEqo+LajFeOuws2nRudAFHdc02JqLhOWRIT48Lz47ELujLg0c1cAN
         XRKsyG3qkWAxWLhe6aOv+GTPnh3o4Gj2ctiSshhvqQKMr6tIHTBVVdx8qE/4xBxJ96BE
         DWJ9NsZi7qroQajilPxLtgd69LoLZlaVIRyXxi4BCANkei1uhk2kAnI1QbDGnPtvvwic
         oOm3Bw4+6KuFdMdL58Udqd7wPmYBuVCuazzvfuQ3CCzlfSTPVmBKm9Ei7nq+fTQlqWyl
         ShGw==
X-Gm-Message-State: AOAM530wGgKNjyjhHvTol+0BH1Q3Lm8pL33J13eYO4oASD9SUaJPoqfC
        U9o3ZH/awfQn0gioqXo2KeMr+gfdewc=
X-Google-Smtp-Source: ABdhPJwQCW3S9eLVWohbpnF8eE4wiMojBQmCJs6SOjxhI7Rlta5L3+ZsqTKJ0wyYSNRTKsAozmZPNQ==
X-Received: by 2002:a5d:4892:0:b0:1ed:beaa:778a with SMTP id g18-20020a5d4892000000b001edbeaa778amr19040043wrq.35.1647334478252;
        Tue, 15 Mar 2022 01:54:38 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm15139021wrv.10.2022.03.15.01.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:54:37 -0700 (PDT)
Message-ID: <af6cdc21-761a-fa4d-a45c-a0eb6cc1efab@grimberg.me>
Date:   Tue, 15 Mar 2022 10:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Content-Language: en-US
To:     "hch@lst.de" <hch@lst.de>
Cc:     Sungup Moon <sungup.moon@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
 <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
 <20220315084611.GA3961@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315084611.GA3961@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, it can't change to shared as the nsids are non-unique.  If we
> want to be paranoid we could add a sanity check for that, but then
> again there are a bunch of other things where we could be more paranoid.

*** paranoid person looking over his shoulder meme ***
