Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F54C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiHFPWG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHFPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:22:03 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F57C12AA0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:21:59 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id q19so4623033pfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 08:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sbk9/m5plrdXfwtuka0gvoXPxmDQEHzMHm3VAck3dOc=;
        b=XILwPEbaG4gFA7g5z8igWq9IrAgyyvbcZAw/rbuNvL122CuDWgtrYvyMGsJh0cCG5o
         nsoid2UBqT91gNAroJCNVm5fEMhHGV09NtP5ojm9NGF8NEK8EQIrEV8wCESfE2r5WA74
         YCGSFVTKIHwhK1TZoqBe0wuXSGb4vGLhQlDmJZxEo0iVN1hVT3o3S+L0u6cbl8ZZJUhp
         /8q2ddxTsBh6C9ZyGqn6txzpgMNp7+HxA7FX7R3gu+nqDOL2YwleVul0J7/5pr7BbxXu
         V2nxhLsSOEcDsXBuvYyY7q8n+toa8/ztbuckqPbZrBrj7+rwW6qP0azB8xSTKSHzZUX3
         BhBw==
X-Gm-Message-State: ACgBeo1lTyeqgq8GIzxm/BJ9bpGnHA6T21/VDCOXIE4M0e5+zvke3Wnz
        0jfmzEZ3VYmtY8lD/Cf2LXI=
X-Google-Smtp-Source: AA6agR6tzdfrA6tZXBbmdlJS1sQV9NOORHZsah/PIkpXjvDTRtY9ipC75/xqBdepO1U77KDX+2d0cQ==
X-Received: by 2002:aa7:8895:0:b0:52e:c742:2f3d with SMTP id z21-20020aa78895000000b0052ec7422f3dmr7099411pfe.69.1659799318688;
        Sat, 06 Aug 2022 08:21:58 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t188-20020a6281c5000000b0052acb753b8bsm5131384pfd.158.2022.08.06.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 08:21:57 -0700 (PDT)
Message-ID: <dc0dbf3d-d524-7edc-6fbf-0067c75c3d03@acm.org>
Date:   Sat, 6 Aug 2022 08:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: drivers/md/raid10.c:2647:60: sparse: sparse: incorrect type in
 argument 5 (different base types)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202208061258.jAwlaAXe-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202208061258.jAwlaAXe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 21:44, kernel test robot wrote:
>     drivers/md/raid10.c:1139:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
>     drivers/md/raid10.c:1139:30: sparse:     expected int const op
>     drivers/md/raid10.c:1139:30: sparse:     got restricted blk_opf_t enum req_op
>     drivers/md/raid10.c:1140:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
>     drivers/md/raid10.c:1140:52: sparse:     expected unsigned long const do_sync
>     drivers/md/raid10.c:1140:52: sparse:     got restricted blk_opf_t

I can't reproduce this with Linus' master branch. It seems like the 
kernel test robot picked a commit somewhere halfway my patch series?

Bart.
