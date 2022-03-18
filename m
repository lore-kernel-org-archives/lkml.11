Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92222C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiCRHE4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 03:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCRHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:04:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1E6E341
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:03:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so14435860ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QnHQHpOTgabEjZ7FQy/cLMZsS5a+z62yl/RPsQ9TFI=;
        b=ejwqej9fSv1GrF/H7RnraHiJyiu+f0zh485TU+/N4propfaqIbs3tpUSIZ40ya2KaK
         VbVEje8kwGNQeVdQv257qwQFrZjopCl/gz8+5h1AwdwGm3pXwchxvtSgiWTapZVnqBJN
         s/jcL+Z+ax1QeFJ9sQuhifKAU45wW7c8zbWdq2QxsAuCjHL8P24KMcKp/H8ImFsoe+5+
         XxFUDdqxW0qRsL7Bk32WNOHb/PmQ29hUSmwx5BKyweyH7VA+VAYH8lIMHivRS703aP5M
         mT+gEhKrcl/I4IeZjVcW9Y4OVwTbxqldlHFxHsG5lFuEN/LHUGJUYZ9UCUNKusgXID8P
         oAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QnHQHpOTgabEjZ7FQy/cLMZsS5a+z62yl/RPsQ9TFI=;
        b=w6gjAkaxaAJrVQqP4BlVZamYsVKHXJ9igs4m+ibqtOGa6QBVeFRCeJ7DRVjhbAn0+j
         Vy+q6l2oSvCpB8Qwrq251H/BOkjH3b9vIR7lh9uhKfCe3HaLeuEXp37G7PJBzw0phlhd
         U+zVXFkfZRdSq8bcBI8LE1gGfi2c6Jarng2ZPd6vSpaM2QhnYWOwmxdXmbzC8LCPWNHx
         dz8tNm0OTCudw2qlHyo8Jd5cDGC8btP+w3UXVMERH106A1PrJ1TgkIPr1SZAKCTknlWk
         GF+9dJ2um2n2upTKqsaxyFj/ob5BJvwGcDXHt0gySLJgu0Gt+AjovqeLtweJeddyxS6P
         tcxg==
X-Gm-Message-State: AOAM531yo8bTD/veW2O5HMMhAk+Ysps6hu/9zS/hhhah+RSXjZnD8i7j
        CjfSL7Mw2RXAJvfGxE+dsOxeE2n06Oa4fJROA8lWNQ==
X-Google-Smtp-Source: ABdhPJxaOaz1fWZM6gdOZptaXqLqzwSJAIxLgd+18VSDCyfW06NqLV9JfyAFpmySKFc2Y1UNl9kQcYsUh3aYqNnYfXU=
X-Received: by 2002:a25:8390:0:b0:629:2839:9269 with SMTP id
 t16-20020a258390000000b0062928399269mr8833219ybk.246.1647587014609; Fri, 18
 Mar 2022 00:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220318111709.60311-1-linmiaohe@huawei.com> <20220318111709.60311-7-linmiaohe@huawei.com>
In-Reply-To: <20220318111709.60311-7-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 18 Mar 2022 15:01:42 +0800
Message-ID: <CAMZfGtWWKPc=D6a_D=eEq46TX3WS7VBJa_Xa8b=G1JBUDkBzOA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] mm/migration: use helper macro min in do_pages_stat
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        baolin.wang@linux.alibaba.com, Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:42 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> We could use helper macro min to help set the chunk_nr to simplify
> the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
