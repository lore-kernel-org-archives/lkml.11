Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6560C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiDQSmQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiDQSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:42:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E2124F36
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:39:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so21322461lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4fx1hE4/XanHvXXT61GagAtRkg7k3tgW0Yywww1X/E=;
        b=FEccoRnaF+wbNXngW5iZweCAocsqLhshHwThOJF6lZswLZbeUUkZJlHXWlqwYvu2zh
         M6ncNqOqhSdo8d0h6tcZAH0cscsrN4GQj3wKFmXZIgr/YNtoQylktDQ6T0NwCPLzx+Zb
         UCfa6UQWqEocDxiT9sS+j8rhj4cHHVfZvRYiWLJCoJe0c2v1mxt3yQN9NmWmE1QZIxFe
         HDyRfhqmjvoIy/MN7AlJQUMyMyC/9X+OV+dSXqpZEXPkl+1+OyY6nzO2neMzYhanmAlz
         3VNJtEcmSmxMjyWNhi+jpm8saHRv/Xv8IYnE8HiDOYMOW1pGVbcazbvNURWkmjqemdcL
         4IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4fx1hE4/XanHvXXT61GagAtRkg7k3tgW0Yywww1X/E=;
        b=tBL2XuQTBkB2MPWfOzF2PoFLgowWFlQVk2b8ZGgGB9XTaIddXZXIFHmzxhBWLw8j1T
         mqUgthqJBdmZSqEcp7z1in04DA0I9dmuYpHbiqv05I2k3UH1xiWaf78cR1WbQaP6KhRX
         qTiBqM+KC65OpRwhjkv2sazKNU3kMC0W2gpdtGSwrivAeVxXhr2mIeRIBJWMB8F1jOZT
         OG4EqoLdreat0rVxp0JC9RzsRH0q9o36eToAzsBsgMl1KaXZxUZvDojxosQcBtuFJKph
         9biFJb4byPmclBdCc5ogNmZOuGgoYQDW2M3rAI7fBdmvAYCRd3wbAoWE1qNP/RaHo4Ow
         +asQ==
X-Gm-Message-State: AOAM530Ee6vNHHpAA9pW/FDxAaDP1W10ng5/iSZNZjd3GiKCfzDqtEhq
        2Q3rM/TEm6FGXDXD2/cKhyU=
X-Google-Smtp-Source: ABdhPJzA+VxQFkx8HmF0tiTX8iqmLNuHvigncHHa0RSibVSg5k0iQLaeVAuqP3PChRgmomWCGz3WGw==
X-Received: by 2002:ac2:5296:0:b0:46d:da1:773e with SMTP id q22-20020ac25296000000b0046d0da1773emr5704173lfm.197.1650220776577;
        Sun, 17 Apr 2022 11:39:36 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id p41-20020a05651213a900b00443e2c39fc4sm1003889lfa.111.2022.04.17.11.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:39:36 -0700 (PDT)
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
 <YlpcqOUK59yExXlq@infradead.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a8ef5394-3eb8-cd2a-f61d-a38277407eed@gmail.com>
Date:   Sun, 17 Apr 2022 21:39:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YlpcqOUK59yExXlq@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 09:05, Christoph Hellwig wrote:

Hello Christoph

> On Thu, Apr 14, 2022 at 10:19:31PM +0300, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Various updates is a big indicator that the patch should be split
> further.  Please do one change at a time, and fold updates to the
> previous patches in the series into those patches instead of fixing
> them up later.


Sure, next (non-RFC) version will do things properly.


-- 
Regards,

Oleksandr Tyshchenko

