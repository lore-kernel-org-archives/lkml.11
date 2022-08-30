Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F1ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 18:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiH3SUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiH3SUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:20:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD3286EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:20:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y15so6053245qvn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=v7euC2XHMrmAIDs4GKnYbtV3VOiDosmUFBqV2phdzyw=;
        b=glb0hDfdM5bI/oVd9EIzja+8TNpzsd+7nSGbIgjqt0GnRA/xEbPNCphFoWREpaPEvq
         jIcWy3vTkx0LMZm6yz9Jpod0M59ciYf3n4QTXFOIfmKVFv/gwyGkQ/6DAsR39i/tDLf5
         SeEsJcHCuulnxBs/Unw+VSJ1w1fPP3sCsya8h1rsZMC7DZ09YaZD4oBQqWwfhgCP6tIg
         ZU6dMIi2rQW23uc4/M8+HMKY/+LpCs0pPHkQaGenF2JuCcmrB5AvbBCIZIZeO23T3vAZ
         WKH+wk01VoNvqFJcqVqT+gx3d8qSvbsB/aZ5J7Wmb5p0Qfm97eUH/XSrW+KOUM9WBs5E
         oOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v7euC2XHMrmAIDs4GKnYbtV3VOiDosmUFBqV2phdzyw=;
        b=UYCCUQsGR5Cv/rqeMYJgsmFCTxv37Z9paf0OyZ/usNVHQwOTZXyy42hJecIitmwYOO
         +qvOMTOhQ/S4YP6MProoG3ChyYQ3R4pdLZVcDUusbCp6+Isz1AjWaBmbJncmUstjyoUU
         TaJRtdHI4hHtZODBc0RAXQZ8kuQJ6oJw+0BDlQXzKTMQMwOe2UPXYNMddjAzZRIQS5Jv
         CqRZd6/+i32y5E3YTNy/JLpskB3L1hMq5YFPvT1/f6Afy7fHzVG1OauWbV399tnbj7uH
         NSVgpTA6trhzlLERXY3bu2i+uJ0hoYIvCUjisEuoBHUA8pWgOA30KJBigmrFzFZipfLb
         3gRw==
X-Gm-Message-State: ACgBeo05lxgjsP53csS9lb0nhpaXyVM1n47xiI1zwbf7l0B0pVhiF8SX
        egtGi5YiD6ycYyEmydIc70jfbG7yj5maz2eF+Rgq9A==
X-Google-Smtp-Source: AA6agR4Q9dYlXcQynx4E3Xm9Se1fuxtr7KH/CwbjpXc//KNUVTp4Frc/mXJct6oPykLZ2T07iHx3vlnDQagRJ5sj9Ns=
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id
 s26-20020a0cb31a000000b004738062b1b4mr16537151qve.85.1661883629355; Tue, 30
 Aug 2022 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220829231828.1016835-1-haoluo@google.com> <c84fa46d-8f37-c449-06ea-5da795f091e8@fb.com>
In-Reply-To: <c84fa46d-8f37-c449-06ea-5da795f091e8@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 30 Aug 2022 11:20:18 -0700
Message-ID: <CA+khW7jyfAooaiGGuiMU9XZvSUrPvkgi492Rfit32hidtkvw6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter link
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 9:41 AM Yonghong Song <yhs@fb.com> wrote:
>
> On 8/29/22 4:18 PM, Hao Luo wrote:
[...]
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Thanks Yonghong.
