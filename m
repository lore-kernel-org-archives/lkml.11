Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FEC25B07
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 02:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiHJClL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 22:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiHJClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:41:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53AA2DCF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:41:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so13091064pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j82v1An9Y3qtBDNPcX53vPR1d/6XIUFLxPcUa40OMz4=;
        b=KW5PA3GqrgkrCPYHhYn+9pArVF9MbYvRykSDm7WBWwHlPFFdaq8yrY+qlo3WK+RsRJ
         4Ci0xGKZacsW9FVQC+8e7GXISqAQgw3Y8hIOxUoCuOghxkgqilBYnrtuo1XJOPf1tJKw
         xl8ZstXN4qeMHR4x4CuMlg+9Lz/XKAKpbUT1VGLYOEdr5KCNVaPvQavr6b5cV1wkE/fR
         5GBJEuE1+i929vuQ9WdQZXZZstubdm+68LI+SlFE6RBKrVkP7C17+SbKKRZ/e7Z/egaE
         915sh+pChzbK7d5+4xPDOM+jdKOuuvrjFhTPrK++AxhRAHiHq0W+EQXNXLuFLWtEeXci
         /VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j82v1An9Y3qtBDNPcX53vPR1d/6XIUFLxPcUa40OMz4=;
        b=H2gRnY6ndHzjPtduEhyBJ3uyFp73FR9/qhE5PdLOhdiuTvVYYILDlAYdtOl5gzz0wb
         +1/L69eLqF1sUarack2IHNQgyANmZivOMxLM1oAP5L39EbzAtZCnqy6B9KxKV7hcpRCv
         SckQ6mIyK0e8N3v9h8ZBOvhoMAffaSanTIBY5+Hyz9K3ULvvhqo7iBvFCVh/SLfw/1xw
         iISys0azV021AnW3VDfU4MjbZNMp/mOaEbTdQmsmRm7gUmS9cV6FUHtPx0/W1e5aVN03
         FKFqGphE+JIMSr2vOlqTU6n1hISMBhWPKDdt3oXbVq6x3BVBo1bUkgIWi5pdQrpxlYQ1
         TlYQ==
X-Gm-Message-State: ACgBeo1wCc1TieiOICRxYtdgMfGnIPih6u9/HOoD8JPS4zmx5RHWS3JE
        95q4Pc7NE/VlmxbiNVkKnAo4Y62s/VPgOQ==
X-Google-Smtp-Source: AA6agR6piFyoFiMPTw+wZofRf5fNgpJg0YhPFB8AQZp8bauhOBrrhiCxMAr6fzhey6VRE9Sy/BAOeg==
X-Received: by 2002:a63:d750:0:b0:41b:3eec:f9d0 with SMTP id w16-20020a63d750000000b0041b3eecf9d0mr21269662pgi.289.1660099262876;
        Tue, 09 Aug 2022 19:41:02 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fu6-20020a17090ad18600b001f1ea1152aasm298869pjb.57.2022.08.09.19.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 19:41:02 -0700 (PDT)
Message-ID: <8c5037ee-135d-a338-4e0a-ac4a385ed1dc@kernel.dk>
Date:   Tue, 9 Aug 2022 20:41:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [syzbot] KASAN: use-after-free Read in __io_remove_buffers
Content-Language: en-US
To:     syzbot <syzbot+6a8a923895a61a5dbf18@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000008909d405e5d970b8@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000008909d405e5d970b8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: io_uring: fix free of unallocated buffer list

-- 
Jens Axboe

