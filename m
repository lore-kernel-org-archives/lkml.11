Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87722C19F2B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 22:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiG2WtM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiG2WtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:49:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4D85F84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:49:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m7so4676388qkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PHjNC5/MEnwibKTgt66y4B8QHXUMZZ8F7xsD/e5vT8=;
        b=h5vuR3bE9y86uyovtmo+yMSm360p7Vfl+m/49LSoNn6riovGoQldvmVXCT7DMuEA+M
         IxaHvlgpbrKuzx2KC81SJNf6wnUn5SDvFoEVVZT+mYB5ZvGliFP4XHH3cVBpAOFOrFrD
         +HlGmxArwenxwq3vCI6EkqRmtcu2JHfggoQLhMQ02F5fv3eM0WUfr+OfmUW1HqKpsrEW
         u47RbtzG0G/WyvxcmydCuApqYXvYxUxf5TSTMstpcA5rC6TrJdpHCoTL0AWFsqU2NE4N
         cH2+YQIN6Zw7OPF2QJ+/zrQj2UvKU33Fw8i1un0LliOyo9O6HWW/q8wJcqATrNPgKyrY
         JcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PHjNC5/MEnwibKTgt66y4B8QHXUMZZ8F7xsD/e5vT8=;
        b=wxqn/rXRvCpYtxvcjqDgJGwvVCaaobOg1X3dOn8SE9l60M8CsF2ErWk8vP9qJvNgsS
         oRbIoXMMdDcze0R999WgTHdV/K5vvSRrWqEMJ6MnTd+3u4nggZ5JS1H7HitIl6ifGJao
         qU2rZVshA/eXj89I3xRw74cbEF8Nujk278D4ZRFWBNdkxEf+FUSr8tNZmWxVj+YzWjSO
         NpehasHE1wMrl1rCLI0vDvi2nxc1+x336AyhK81SooQ64oBtWNv7CNtP5LoibQ0jt+T1
         GECGUpRhm8ZL31jexSlnfEX+esnko34I2npl3i8OS+iaCCE3F0Mnwam+aZ7sYWo+aYnc
         M3kw==
X-Gm-Message-State: AJIora/prDhixVodIRSiNyQ/gnHWcPB27UGPDkbQjcgKfiVmOIhKDTlv
        +n74gwZZWTxaxK/Fbo9p/lvGZCGzXos6+3XX+iPbCA==
X-Google-Smtp-Source: AGRyM1uerL6gJ1ZFWTeneCIa8WSwBLci00q0rhU6N0/noz4neg/CzP0j0yv4ifJ1Sjs4tut+nLC5fMrK/suZn65SJSU=
X-Received: by 2002:a05:620a:f0e:b0:6b5:48f6:91da with SMTP id
 v14-20020a05620a0f0e00b006b548f691damr4443449qkl.446.1659134945084; Fri, 29
 Jul 2022 15:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
 <20220729224254.1798-1-liulin063@gmail.com>
In-Reply-To: <20220729224254.1798-1-liulin063@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 15:48:54 -0700
Message-ID: <CA+khW7iLeSZPweZEz_tfP+LRtpvZbfvstZWgUbNrEDK-Ntxyxw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     Youlin Li <liulin063@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 3:43 PM Youlin Li <liulin063@gmail.com> wrote:
>
> In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
> to get more tight bounds tracking. Similar operation can be found in
> reg_set_min_max().
>
> Also, we can now fold reg_bounds_sync() into zext_32_to_64().
>
> Before:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
>     6: (95) exit
>
> It can be seen that even if the 64bit bounds is clear here, the 32bit
> bounds is still in the state of 'UNKNOWN'.
>
> After:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
>     6: (95) exit
>
> Signed-off-by: Youlin Li <liulin063@gmail.com>

Looks good to me. Thanks Youlin.

Acked-by: Hao Luo <haoluo@google.com>

Hao
