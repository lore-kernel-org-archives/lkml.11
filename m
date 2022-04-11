Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 02:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiDKCKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 22:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiDKCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558721AD8B;
        Sun, 10 Apr 2022 19:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB08A61034;
        Mon, 11 Apr 2022 02:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA4BC385A4;
        Mon, 11 Apr 2022 02:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649642893;
        bh=A2X4Ggu+fzkw8crm6TaebmjPFV7+g5bq3xcZ2A4fLCg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=hgQ+OykPY+Sg8QF74TEL66QxdMP9rL89DLwn/OGuJgZIv41KC0hOlu8XGNTcJFVJy
         0lLkjeb+x5lhH7+/QWwqc+rBa/4Qb6+lmNKzW7SIZS4YyahuLFWu86OopgmLhSmBqZ
         UJHQk4JIKazosTkqQuhtK/ZM3NbhVnL5ITv67ovHuDSS6T8t3IOu5H4Isi/At15E6l
         kt7SHJOxo100Rd/NLAQY3p2AVlCAzN0oPgy0AQVCd21CEn6wkQZLbsgQEanb82Au3n
         o8DcYCLAqpTnR5KPBrclyx0/MlR4X8yW0aQ5p6gHLGJAR+phPlj3W59HA0JOuBRomj
         awo5/ZM2N37Fg==
Received: by mail-wr1-f41.google.com with SMTP id e8so4494118wra.7;
        Sun, 10 Apr 2022 19:08:13 -0700 (PDT)
X-Gm-Message-State: AOAM531qquvfUn5kt4tGcygYI+L9yUkFeFhMbdYHNVOTTz8wql1m94dr
        gHuwmfRSXzrIrktf1TPmwl5Dz8MORLdhJpNSg4Y=
X-Google-Smtp-Source: ABdhPJzxPJ+baW4cPTMyPKAV7kJwIZWzzyNnjB6PMm6df6YwIOiySr98tevUGgyHNUJ5ejCBTJdQb6GzaezF6x7EsFQ=
X-Received: by 2002:adf:f78a:0:b0:207:a5a4:5043 with SMTP id
 q10-20020adff78a000000b00207a5a45043mr3114901wrp.229.1649642891494; Sun, 10
 Apr 2022 19:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Sun, 10 Apr 2022 19:08:10
 -0700 (PDT)
In-Reply-To: <Yk/DpSwR8kGKWJYl@infradead.org>
References: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yk/DpSwR8kGKWJYl@infradead.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 11 Apr 2022 11:08:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9NAUjdxT2GOWGoPvH5nOXSFtD7u0t_9rCiZx7hSGC0PA@mail.gmail.com>
Message-ID: <CAKYAXd9NAUjdxT2GOWGoPvH5nOXSFtD7u0t_9rCiZx7hSGC0PA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] block: add sync_blockdev_range()
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-04-08 14:09 GMT+09:00, Christoph Hellwig <hch@infradead.org>:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks for your review!

Hi Jens,

Can I apply this patch with your Ack to exfat #dev ?

Thanks!

>
