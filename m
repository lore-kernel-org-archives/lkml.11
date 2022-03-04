Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiCDN7V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiCDN7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:59:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4F54BCD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:58:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e186so16997096ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OAmWvG3KlYliyUdPO8+7WtwcRcsO7IgmHEGERM18j4=;
        b=LtlQCrh+7W8CujhTYtC7bpijhmuzbaa1k1zjs0SgpFyqUGRz8WOt0uJU1tofv37emS
         j0Tc03GuHP6RyJzJBhbyuLl2jiVuDpbNkZwj7M4r6ZvCYcmRc4qGQi8N6bWBNeUR2CuW
         D/cqfnLJo6m+iElu3pweUWbvFYMY14FIK/OuTQYG+yyE9AYAUR5lDV2IZy1m5bMTd9X2
         dYi9lSH59nmlllOJcAsdLEE8a1d+vXu3tAI8SbJYzjyhRHNl4hrZT65Bu/GWWl1go34g
         3q137hVTNkjyTxNZtSwqVN/uroD1Cmur54Dc2LMUGuLPPKJSCikk1kRG2ooomhSppknI
         QKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OAmWvG3KlYliyUdPO8+7WtwcRcsO7IgmHEGERM18j4=;
        b=noVmBKA8ZVRNPJxcTxSQL3zyb/tOSAVn+TGraVDGV9AQVFGAlxnvNLzslyazGrMk01
         dxDsq3iwkh+W2GDzr21D/l/Rxn/uRft0rzOJ/ltDcF+Owvx85knt47jnoN4Jfe3D/sEP
         K+Rlj7A8EOBGl7FUTd3nBBG86oYDF3i5wbY8xduMu8d6Pkn0by7TctFSRvjaHP05p9k7
         Ir/HCiUcrMu9vWJV0dwBUpN2Agy6bBYOSAA6sN36ufgIbfeGmQfMf+kuelTicqPmegp3
         e/VwqT3G3gAavcSw141gMvQO2lNS05eM+dPxSNgz2RX0cw2RZizFviRWwceP33YICgro
         alOg==
X-Gm-Message-State: AOAM530/5gWMYeVwIuULY80ikGejoWE3WoDvNDXJNH7V6vWeApQ0busm
        Nu9MgiE4lL7SwY7Avpj/zF4Bhk25XUYCg3DRC/gy9w==
X-Google-Smtp-Source: ABdhPJylq45Riicfu2OMlNkEtOyToXUDF13nXxVXclNZnwOWrHQo3TxTofddVY8hVSj1+0Vyn3qlczgB0QxFxRe3bOc=
X-Received: by 2002:a25:951:0:b0:628:db03:1132 with SMTP id
 u17-20020a250951000000b00628db031132mr4723852ybm.132.1646402301511; Fri, 04
 Mar 2022 05:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-9-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-9-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 21:57:34 +0800
Message-ID: <CAMZfGtX6ee6KvYsPHLHTP8ehY=Lu-6HRk4pB52R0t6HxiaoO4g@mail.gmail.com>
Subject: Re: [PATCH 08/16] mm/migration: avoid unneeded nodemask_t initialization
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        riel@redhat.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:35 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Avoid unneeded next_pass and this_pass initialization as they're always
> set before using to save possible cpu cycles when there are plenty of
> nodes in the system.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
