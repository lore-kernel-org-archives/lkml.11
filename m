Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB40FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 08:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiEaIpQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiEaIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:45:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA18B0B9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:45:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k19so9482409wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/soQX7cHnl5XSUE5+d9yllfat2BblKyTnOMUTVdeXJ8=;
        b=cVTpXzFeNKwIU2APW6nE3zAk2am+rmChC4nFgSpQJd8KEnBDtUL9zDCDMTJs6JUovG
         zuXt0h5SJ2XgSvbd3/Jclq7pF1HFpKFaD59UjHjeavLp7cxAPLRbddByosb4brOI/aNT
         mKuIy5bn/zewUzH3+Gc1b0uqvUCc1bNgt3tMJukDJVNH4lapzr14cH5CeZW3A/XLXqjR
         SgHGv1GFycnNlHDVt9kXhEGqtfGceNcWW6u7raLQ98tsf+Hpi6WMsxe9OEri07P3mrLk
         NVOgsYmHOozbkEKH/0jVDfhlyKjRKXo33dpvy+/Qbr+TxCKdZS+M3khLhOuaGH5Gy32h
         b+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/soQX7cHnl5XSUE5+d9yllfat2BblKyTnOMUTVdeXJ8=;
        b=wnty+NgGT3iQRoje+twOheU1xDQ6BAZ2h+2Hf/7bP/eWcwXT8GAPxyhVkSIDWKJoEN
         Mx4mMJ7f5vLSX3Oh/CRol3uz2zaIKkfoEvLnoiwheNVa+ZKnXew3ydN68z2+QGE8G0D7
         BKIkl+LftmeF3X4TsaK+w1dp7nSBAO/SuyPjGhAcj9ujqfIQq9taOzcZp/doPpM8Ytaw
         zk6RditMXP0NxOpXRNpRyAPW+SCXmiJJ7In6RqzlRt8MHWzKrIpDMZTOwvgdMtOJeZ71
         dLVpd4gBjFn92gC37ESR89XzzDsDHtRi7SKH0sTDpD+ONE3iXq5Xa7k5T2whieCczWqJ
         C6dw==
X-Gm-Message-State: AOAM531xJslycMh3gsmYFbdb6C8tNioSPtQXQbDoLE9SZTGKzEwT8tKX
        Xs/GuYqswmqlk4YIo1N6/+sHUg==
X-Google-Smtp-Source: ABdhPJwiWzJyxo/ze8C7NGWY9vQThUxotc53evucPB2F/Sz4ZoZc7yO/z/VH9oDIhZKAXjskijrpeA==
X-Received: by 2002:a5d:6c64:0:b0:20f:f413:8af8 with SMTP id r4-20020a5d6c64000000b0020ff4138af8mr27888592wrz.129.1653986705746;
        Tue, 31 May 2022 01:45:05 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe38f000000b00210326c4a90sm5291477wrm.49.2022.05.31.01.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 01:45:05 -0700 (PDT)
Message-ID: <3d3c6b5f-84cd-cb25-812e-dac77e02ddbf@kernel.dk>
Date:   Tue, 31 May 2022 02:45:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in io_submit_sqes
Content-Language: en-US
To:     syzbot <syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f0b26205e04a183b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000f0b26205e04a183b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 1:55 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b46e4e44180 Add linux-next specific files for 20220531
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e151f5f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ccb8d66fc9489ef
> dashboard link: https://syzkaller.appspot.com/bug?extid=b6c9b65b6753d333d833
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com
> 
> ================================================================================
> ================================================================================
> UBSAN: array-index-out-of-bounds in fs/io_uring.c:8860:19
> index 75 is out of range for type 'io_op_def [47]'

'def' is just set here, it's not actually used after 'opcode' has been
verified.

-- 
Jens Axboe

