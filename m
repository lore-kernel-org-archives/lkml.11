Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB058C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 09:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382513AbiD3JbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382509AbiD3JbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:31:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1A6D198
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 02:27:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso9188157pjj.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q8qHMhJMQBqSJ03OXuT+IFnkEqmRiLr34+uZsDtGFNQ=;
        b=Cln9kklLfm97JNl1D1cfvR1V0J7WJHU6CDo0e+4VkvtFr0aAWso0SsYR/PolmKASDz
         CvzulTqA8QhW0wlLOeKDcICiybthPHDBfFdKM0xWO6BEFl8i8VPD9793snFwLm2EB0Qw
         ny+EKYnZSHyUf+CfbosR2UL9ZUGpkIOydUrf1wpYCbHA7d8VBnbH76EdqicA6xjVxCgu
         NyPR2dJsRV1xuDRG4FzvZ2gSAsegrU0xN7KJw+eFZIewsQRH9QFQ/9s2nU8OIoga8PAV
         Q1AbJkFJyDR+KIfcJ79/Vlfr7KHZ6Ur5g3eUUAbHqv/M3otTsohTocVWmALaHvHjS1Mi
         CdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q8qHMhJMQBqSJ03OXuT+IFnkEqmRiLr34+uZsDtGFNQ=;
        b=enwDmODRyZbAzb3RwEusVqhdw3Qzsg2HPtXQA1m0E6qh5YqXw9XHZWXPt76/71yBFn
         PtQQtFIr+9DsK9KcRfcIydE1s74Zf0VDFnB9unc+FSf8NkPmNMbKnJEIXJ15tPfeLo/L
         HNV7/G0l3mdmZBImx4frIcCPqUmWUOCz4Rx2BbaMRPQ2p46yUoGpKfIG0sBZB+G1ZdlY
         5BpqwbSOgNs1nir82eDZq6eEJz9Gmb9flZeitwo1nJ38XffsblygWd97HCJgDtvG7U7L
         sCNC9rZr5HegmsccY7kC94ZJr4SUmNmxdZlVGXkhGzLE12oPOWqV8u7iYfCe5GtHeVpE
         GrEw==
X-Gm-Message-State: AOAM530lPZFooGGPw3XhC5mmkMZbHnQKFXbd2mwFlItvJGZWeFXvtAAS
        93No2Qqj4BooeX+IA3C3IS5JWS0JZiSmNKPuf/7s8Mrn3Ce8hw==
X-Google-Smtp-Source: ABdhPJz2oOa1LTq+9QOZY4Mzq3O2FmJ234VLWn0JyiqWSPJrOtmEbs9kWYE6YJy8K6ku0mazALZGKqKO3HD+O5L/Zmg=
X-Received: by 2002:a17:90a:343:b0:1cb:234a:a975 with SMTP id
 3-20020a17090a034300b001cb234aa975mr8377949pjf.83.1651310869197; Sat, 30 Apr
 2022 02:27:49 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Sat, 30 Apr 2022 14:57:38 +0530
Message-ID: <CAFf+5zhf=DYasOrSYwKXgTQ0j4hdpHAZD-FhzzuJbrwzuFn6yw@mail.gmail.com>
Subject: Just a humble suggestion to kernel newbies/people: Kernel
 newbies/people can contribute to FreeBSD kernel as there is not much to do in
 linux kernel now as it is quite mature.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to contribute to linux kernel, but I didn't find much to do
as linux kernel has become quite mature now.

So, I have now decided to contribute to FreeBSD kernel.

People who want to contribute to linux kernel, but are not finding
much to do in linux kernel, can contribute to FreeBSD kernel.

Regards,
Amit
