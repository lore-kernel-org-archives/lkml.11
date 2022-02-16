Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4990C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 10:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiBPKvZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:51:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBPKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:51:24 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA412AD9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:51:12 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id bj24so1018193vkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIKz2AezeBlsV735RvnAexh8fOwlUs4AtVj0CV5E4jY=;
        b=bJMHEb/+6AM8y58sCM0vR2WBJ6fD3lI/BkkZHADrAS/QLU2Y21gDYyxF0LoHdJT1OL
         84K29/v7J6xmTazyaK+/7S/V/uS6RcDgvHiqaosW4JIe0sR70VLXR/1Y0x9nOO3V5xHz
         EqaiQM0PDxMoWdR3X9dI27LFMmRjP/CLOPv2BvzohiHe1iW/RHZNhOd5vPJJO8Y3Jrnv
         q4r8xIkxXmfdr7CvId0G4Flc345mQ2t4UYwCVjU7c4w0zGkUgeQ8e/VtxVGR1GH69qm+
         MeZBPqpjUp8OeM/UJTZFaMVjOkGLQ1piAlF0TrVQFqDe5eex4tDahMokbvN56cCy63Vw
         bXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIKz2AezeBlsV735RvnAexh8fOwlUs4AtVj0CV5E4jY=;
        b=jmGefWQBRQ6g87tFioTng2UCBS33FtZkddh/KWBQUpTHZ5WepYUk4AHfjNmD3eZn7j
         yXPnU7sW4ibH64qpbovMS7LmDIPcVUepw9+tI1FVcUi5xCPrlRSdxe0hmXtQbWDpkvZ5
         Q/OsNs6hQlf+RwPshb3QLIoJom3R+e9TjippGB9C/+USEl1WfwFlERa+a4VurCrqnsHx
         091VKiLCdcpzsU6PBYxAqlY3IeI+vh/70dKNtd1YGLxQzT7qvhvk6b6EMqRAJFEhqJSk
         2HIlsrteVkE/+wLMV2/aP6bn2bf6pW7xHlkrFeYpCv03MnWre6vuapd9o5Q0fryItNTj
         OLBQ==
X-Gm-Message-State: AOAM531T/79uG3U+DiEcje3YUR+csrRLa5W5by4JWo8n5INn8rfWCnLK
        av39/ZAm1lPjltzW3FIir3+yWjg09XYmC5g7WjjcxOyMH2s=
X-Google-Smtp-Source: ABdhPJzk9yXjryefk0i7cZBHDfLTYCLHrV26Qk+ZfKYWQbqbQ5Qtqu/FEjeGX18+BGIF81mGfyg39X3rd0uuNw7HbkQ=
X-Received: by 2002:a05:6122:8cf:b0:326:361c:bdd9 with SMTP id
 15-20020a05612208cf00b00326361cbdd9mr623062vkg.35.1645008671300; Wed, 16 Feb
 2022 02:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com> <20220215144241.3812052-11-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-11-Liam.Howlett@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Wed, 16 Feb 2022 10:50:59 +0000
Message-ID: <CANe_+UgS7Gh2i=aPQYO4nrLJ4kL-2kkkrj8Q1kUztsWAAPOWDQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/71] mm: Add VMA iterator
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 at 14:43, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> This thin layer of abstraction over the maple tree state is for
> iterating over VMAs.  You can go forwards, go backwards or ask where
> the iterator is.  Rename the existing vma_next() to __vma_next() --
> it will be removed by the end of this series.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 21 +++++++++++++++++++++
>  mm/mmap.c                | 10 +++++-----
>  3 files changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> +/* The MM code likes to work with exclusive end addresses */
> +#define for_each_vma_range(vmi, vma, end)                              \
> +       while ((vma = vma_find(&vmi, end - 1)) != NULL)
> +

Becareful of operator precedence; parentheses around "end'".

Cheers,
Masrk
