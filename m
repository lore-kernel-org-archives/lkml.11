Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434BC46467
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 07:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiBVHmE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiBVHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:59 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F022D5DFE;
        Mon, 21 Feb 2022 23:34:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V5By.4w_1645515280;
Received: from 30.226.12.35(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0V5By.4w_1645515280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Feb 2022 15:34:41 +0800
Message-ID: <9cd3cc84-a2a0-a827-3fb8-bd2928eabd28@linux.alibaba.com>
Date:   Tue, 22 Feb 2022 15:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] io_uring: pre-increment f_pos on rw
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20220221141649.624233-1-dylany@fb.com>
 <20220221141649.624233-5-dylany@fb.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
In-Reply-To: <20220221141649.624233-5-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/22 22:16, Dylan Yudaken wrote:
> In read/write ops, preincrement f_pos when no offset is specified, and
> then attempt fix up the position after IO completes if it completed less
> than expected. This fixes the problem where multiple queued up IO will all
> obtain the same f_pos, and so perform the same read/write.
>
> This is still not as consistent as sync r/w, as it is able to advance the
> file offset past the end of the file. It seems it would be quite a
> performance hit to work around this limitation - such as by keeping track
> of concurrent operations - and the downside does not seem to be too
> problematic.
>
> The attempt to fix up the f_pos after will at least mean that in situations
> where a single operation is run, then the position will be consistent.
>
It's a little bit weird, when a read req returns x bytes read while f_pos

moves ahead y bytes where x isn't equal to y. Don't know if this causes

problems..

