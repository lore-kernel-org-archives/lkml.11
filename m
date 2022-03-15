Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA803C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbiCONsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiCONst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:48:49 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC1532CC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:47:36 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1561852wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cUb7Ym7YiBit1oW7mIGdDtc855Srmaz5LFm1bk92JDs=;
        b=RbLkJhe2ONOoesLVHPVKoE+CmzSDJ9fankXDOsNEi9q3yAJ3Fq+ngVK6i4pVyHkzvp
         CIF0/QhN6VrRp9xQaLoSMSbOhd000D6bFOIqiU9Y/P+Wn1x2jFPGGf2rsokADkuTuRay
         DkbNYUOtOeaKIrLggQmim1ft3bILNfzDM2ftS/TbGhPu3KfcdryrNmf9cjv0K/vanbqS
         qQPBdcMLrv41EBunluK4CMBV7vYvQNmuWAFdJzYmiGHh6eigFeGfluOU87XWLf/rOJSA
         cmwiGA3yb0efZBckXPy4lTgsHJVzIQLnXxZXKN65jGEYi0SzUo0w21qULn4jvG62hy7f
         do/w==
X-Gm-Message-State: AOAM531AGorKyIN8YHvyTjkD90qaH7p2j5rMcw0hfMWCKPG07yVMVOCw
        uLL2hZ4+nabMx1W4PMzeW0vgGNIFcZk=
X-Google-Smtp-Source: ABdhPJytT3AnIUgNmrWcCS6eglCCV+Fc0mjQURGc3W7lyrFTalBhR8Aju7XTZqMSC2tY0lfe/6nBxA==
X-Received: by 2002:a05:600c:4f47:b0:381:6c3e:19dc with SMTP id m7-20020a05600c4f4700b003816c3e19dcmr3423857wmq.155.1647352055447;
        Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b001f04d622e7fsm15562748wrn.39.2022.03.15.06.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Message-ID: <90024a31-ea50-74fa-1ad2-db6c1db99fef@grimberg.me>
Date:   Tue, 15 Mar 2022 15:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, kbusch@kernel.org, alsa-devel@alsa-project.org,
        Mark_Hsieh@wistron.com
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
 <20220315132202.GA12452@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315132202.GA12452@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
>> Write Zeroes command"), Micron has the same issue:
>> [ 6305.633887] blk_update_request: operation not supported error, dev
>> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>
>> So also disable Write Zeroes command on Micron.
> 
> This still ignores all the questions I've asked.

For some reason I cannot find the original patch(es)
