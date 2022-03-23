Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37DC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 01:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiCWBYK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiCWBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:24:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209696A013
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:22:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so261786pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3fa+Yc6J9FxvaVrYGbZmAuXR7+SlkzyafMy9YlzUS1Y=;
        b=lcp3Vpp0l/asmLNea0dhA5l5wqbg0gfXSPt6GHD9Pg3zwFuRc9ZT+7zKc/sYahVTup
         jJsJ+HBqJBITZnwn1q2uNUUCT41P7If2I8u98teyYM2sCVVF4c6HQFSMjfiMtZ1BmM2e
         5bOaaT54GyvT895GeFjZsAwq0B3dVLUvYsbMGfk5M1bHycYn7K212AIidoO9MO9+3eDy
         zPtoCv3hRfFTe+l/n0+EQyC3lED0CaI4A+WNmSmeFz4+nvB9IdgkU5EVo/kFakThT9Ag
         wvjDlIv6oyl4TCjb9lKV0KT18X/tZ7fdb1o8PrRC0R36M9WINvZ6heEsp5jA4jWtQC19
         ulxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3fa+Yc6J9FxvaVrYGbZmAuXR7+SlkzyafMy9YlzUS1Y=;
        b=2i6Na77oHDFimEzh+FF0eAAClEb6L2j1aqCIDjZMEB6YHoC/h5ve1JOHhXnWOrAFAD
         xFMIjvN3foNsfoU7fY8sNsq1OtNkgclrXczZOkGP3v7qL396Gnp2YcINAZfRvxKoYGmq
         QI8NtJS/YWQUUBP1kFZF+bEdDqvtrnbgDMHxQuxKWSpf5nnZTfuOWoWEHoUNh2y2iwMH
         9sO19qNZpaKKpl2zFkVg+/QnuXVnovAeUQ5bWl9mwRs47meg6kNEv1fSZ8163N0jmQjZ
         2AdsZxK+Ubo045Cv0sjfP4BsP2M1xG2+/rOaU7cKTtK4U1m3NdB11XKQVmreo2ROod9n
         7onQ==
X-Gm-Message-State: AOAM531rT4BT0EcLjl4yC3kxopSlXhxxquXpwgmD6mwCrxDo3YgFsfcS
        xqBLZEUg6ZPy5ib9RDjzZpnmxQ==
X-Google-Smtp-Source: ABdhPJyUAmZjPK53Cmjfm9Uh+CNnTQgtr0ak3s+ROy0aPRK/MHE74gkHWKhj9sljLTmDGUdZpjf3EQ==
X-Received: by 2002:a63:4005:0:b0:373:9ac7:fec1 with SMTP id n5-20020a634005000000b003739ac7fec1mr23892514pga.12.1647998560512;
        Tue, 22 Mar 2022 18:22:40 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm24433102pfc.3.2022.03.22.18.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 18:22:40 -0700 (PDT)
Message-ID: <64edb9d0-859d-c230-edc6-fba0f8a46b98@kernel.dk>
Date:   Tue, 22 Mar 2022 19:22:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] KASAN: use-after-free Read in io_poll_remove_entries
Content-Language: en-US
To:     syzbot <syzbot+cd301bb6523ea8cc8ca2@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000935d2c05dad8883e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000935d2c05dad8883e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block for-5.18/io_uring

-- 
Jens Axboe

