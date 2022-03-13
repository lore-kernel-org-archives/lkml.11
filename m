Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 11:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiCMLp1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCMLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:45:24 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BDB6D31;
        Sun, 13 Mar 2022 04:44:15 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso10256118wms.1;
        Sun, 13 Mar 2022 04:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vCaA+Wh+Wx7Ta4aeT/ck2tjXVf6Mb0nC0oCuYVcQ0C8=;
        b=vbDlQ1Kmpygn0T2K48HSGw2g+liofXV1Kghq9tBgJGHapaUnEgPbxiE4O/ff+C8qKU
         BH5wey/a3xR32A/8abU13KUhuI7IckToz6upCwf9VDNk0Z05t8995RVsX5b2GOeSV/Xs
         4YGSK1XKUaw1wkC39ipRYBYBZwY1T9/95eVV7k9IIqSyyiK802UuVvlh/xEjCFsyIlq3
         w9F8BsBtig+9ml7TNMQKnJqasIgZwbhAt0v6q+twCoelWObNwk6SCiOnGldTwD2PU3r2
         daA1WuIBwIwznorA8BWx2vlP7Ylg60VLEHxsk3aUGSkcHLNEiXRV6+YduOqClDGMQb/r
         3BPA==
X-Gm-Message-State: AOAM532jBYz8dlhMmjRiJ6BQWKF6MMilqXyB/sx7I6KBqaMmtJy0Kdkg
        5UizjUJu/+j3KnIosDYIUZ1e/Rh3HgQ=
X-Google-Smtp-Source: ABdhPJwYFHTtRQ4qBgNnAqWunEUgx1z6UPldJ6h9s9YVPKEFa+nET2P2MzLYmrs6Wg7w4IUb7Zi8EQ==
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id h6-20020a05600c350600b00389d567e9famr13800144wmq.74.1647171854534;
        Sun, 13 Mar 2022 04:44:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b00384d42a9638sm12616244wma.2.2022.03.13.04.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 04:44:14 -0700 (PDT)
Message-ID: <45aed896-ab6a-90f5-9676-e27a7d0128fd@grimberg.me>
Date:   Sun, 13 Mar 2022 13:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] nvmet-tcp: support specifying the
 congestion-control
Content-Language: en-US
To:     Mingbao Sun <sunmingbao@tom.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-3-sunmingbao@tom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220311103414.8255-3-sunmingbao@tom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Mingbao Sun <tyler.sun@dell.com>

Hey Mingbao,

> congestion-control could have a noticeable impaction on the
> performance of TCP-based communications. This is of course true
> to NVMe_over_TCP.
> 
> Different congestion-controls (e.g., cubic, dctcp) are suitable for
> different scenarios. Proper adoption of congestion control would benefit
> the performance. On the contrary, the performance could be destroyed.
> 
> Though we can specify the congestion-control of NVMe_over_TCP via
> writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets that
> have not been explicitly assigned the congestion-control, thus bringing
> potential impaction on their performance.
> 
> So it makes sense to make NVMe_over_TCP support specifying the
> congestion-control. And this commit addresses the target side.
> 
> Implementation approach:
> the following new file entry was created for user to specify the
> congestion-control of each nvmet port.
> '/sys/kernel/config/nvmet/ports/X/tcp_congestion'
> Then later in nvmet_tcp_add_port, the specified congestion-control
> would be applied to the listening socket of the nvmet port.

Please see my comments on the host side patch.

In addition, specifically on the chosen interface, why should this
be port specific? What is the use-case to configure this per-port?
