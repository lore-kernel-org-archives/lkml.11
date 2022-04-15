Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D562C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 02:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbiDOCb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDOCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:31:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584DDE8F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:29:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id be5so6119649plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QuJCosJ75hrvgLG8GUZo7EAhJssF6Kh6uJP8UrR80aM=;
        b=k8qlTK22bUJ+zG5n6SJ1kN9f/vU/hzntumXd/F9Awv/63C55bNuUZaZjeRk4A/pukj
         ktQh4KPddsUnRe8pCCvgVNYDy5pF1F4GQyxUNpdtsZIIYA5/CBlZ8ZzswdGYvQWxXfdO
         w/C1fxRu/PiCXnhQ1PPCp4NpEjo0lPrmkjRQApD7f70Ws595aVk8+0LIxlVfRHKN1CbB
         9Iau8KewiwLn/Diu8DQkEgyW96LDGBjkhdKQdwL41W7pkn5va8QCUBhQ4iwRwLBkuiUw
         V65oKt8VUiv6eMIC71gatvhDu86N5Q2TnGw8FLGRW8kqtje56cyqUZ5c8l8WNJRFtcnW
         646Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QuJCosJ75hrvgLG8GUZo7EAhJssF6Kh6uJP8UrR80aM=;
        b=ypuRVZzFk8ZhS3LXuckvnNngko9987V0icMGbmHchWxJEMgkHA3bTqLJg77ELxu4Bg
         AkWGy4X7u8KHBHH354OPVsM3UMb43okXq33ofUF2OKtv99zYHaYGLMVdj0LvzrpabC1z
         +1Xja+Rj+GGXTy5p0JBtUVBIkHSomV9p72wGbl3nwMBKQr1h+OJipjw670m8yca1FCAp
         zVmkA0QOrRmbTi5O+XIYn8nKjDN/aFpkQzFc70ngJQzOdxm5fnlMuCLTpyOWViPTLOLM
         /vkRJmLxl606vNj53z1t6CkpFC06E//VVuYuFyFMIXB4ka8PxY3nWPb66FoHT7mqJ+QQ
         qrOw==
X-Gm-Message-State: AOAM530IYaYWrPoAI0XJAsgMFBYPVzm41I/YRwyIogA+KFDM+fg0Bh4F
        ych8+UaG80a1nsWtfWalpRUrnA==
X-Google-Smtp-Source: ABdhPJyo6TDFw+/KNXBjSD+rB74L2YUcblRUPk2lwyji0ZFmVGeNLCD5ummE9IKYojEv1G9BJ+alUg==
X-Received: by 2002:a17:90a:c302:b0:1bd:14ff:15 with SMTP id g2-20020a17090ac30200b001bd14ff0015mr1709389pjt.19.1649989766312;
        Thu, 14 Apr 2022 19:29:26 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id w187-20020a6230c4000000b00505cde77826sm1106805pfw.159.2022.04.14.19.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 19:29:25 -0700 (PDT)
Message-ID: <c122ba3e-ef7b-0f70-1972-1bae0ddff651@kernel.dk>
Date:   Thu, 14 Apr 2022 20:29:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] kernel BUG in commit_creds
Content-Language: en-US
To:     syzbot <syzbot+60c52ca98513a8760a91@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, ebiederm@xmission.com,
        io-uring@vger.kernel.org, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a7edb305dca75a50@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000a7edb305dca75a50@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 7:30 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40354149f4d7 Add linux-next specific files for 20220414
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1778a95cf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a44d62051576f6f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=60c52ca98513a8760a91
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1102d2e0f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e22af4f00000
> 
> The issue was bisected to:
> 
> commit 6bf9c47a398911e0ab920e362115153596c80432
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Mar 29 16:10:08 2022 +0000
> 
>     io_uring: defer file assignment

#syz test: git://git.kernel.dk/linux-block io_uring-5.18

-- 
Jens Axboe

