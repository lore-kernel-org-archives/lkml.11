Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiFZTBf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiFZTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:01:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C766055BB;
        Sun, 26 Jun 2022 12:01:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k14so6370907plh.4;
        Sun, 26 Jun 2022 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YhLum+QNHV5LbF0vbyclZG43HtRpC8u5pHO8IwynhYY=;
        b=lWB50lhhRnq1RO4XlPbofPmDbjjuB5kUnFup1XQrZNHclVXf09maAzCAJYr12CqtFQ
         OP6jWhdiEd/vJtG0Cw/PJAf5mSbsLwlZd6zmb3Ubbx/hg8lR0686B4KI7b4bsK3dSREX
         Ypu3jyX9XZ0OyFEFwLG16h2hvQUXz1+OvOF12zwDakfKfxyq2IqUcXeGf9801K+Vjyf3
         +vuBR6mOTKwnquu4OwOGqE7ghw+XB7mWm90lJtg+HLxsHBTBBzn2JQk+YfiWegLrqR3Y
         EdK7KLQvrg3TQoWi0P3ptXtvXOwUqlJIXjabhGCZ+7RhoEe0/ahBLwZUs/qoksDlA33r
         U97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YhLum+QNHV5LbF0vbyclZG43HtRpC8u5pHO8IwynhYY=;
        b=6Dn6XR28LbOC+02UKjEfitH9OyFeclK2zNOeeGKp7qAIls5GNuku+WnRptzvTPkEsj
         +VfnjKxWODdK+tBCFQGQEiMDdCyTW4s+ar8i3LzXSDyPVs2jye42Se/+IjQgX3bfQJdw
         PM3e9UekvpKwRledrsYi53dKxmXgbYhVS9qiGK4tkdRdmfwgtkFjgiueCPql4jvTP4wM
         b09e1HK5HNQja/qnijzr5qBUy2gKvMdJYoqKS2eyaWZrjI6TMX8fmcJJMR0zE2GD9VoR
         rSI6knP1URSRRIorTjHX3KFsOyQBKTRm/HSZ0Aq1OUbWkuERvuxv4nfhZmriO50Cl5WK
         Qh4w==
X-Gm-Message-State: AJIora/PfnfUaaE3KW6Dl70W/WE7mK6DlwZZoX+yU3MAluao4WzCVi7R
        aXypN/PQKxBztco8qpwJFmOOTqCwcrN9aWW8UeFxADZv034=
X-Google-Smtp-Source: AGRyM1vTXhVQi8hLlvc0tyZI14d4vNy6gUF8pDFA9nZyjktyroLjcP5BBi9hjrFL/Y/D77y6J/6B56Mt7yMLtyeDqr4=
X-Received: by 2002:a17:903:124d:b0:16b:8008:6081 with SMTP id
 u13-20020a170903124d00b0016b80086081mr214493plh.68.1656270091916; Sun, 26 Jun
 2022 12:01:31 -0700 (PDT)
MIME-Version: 1.0
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Sun, 26 Jun 2022 22:01:20 +0300
Message-ID: <CAPXMrf-_RGYBJNu51rq2mdzcpf7Sk_z3kRNL9pmLvf4xmUkmow@mail.gmail.com>
Subject: Reg: rseq selftests failed on 5.4.199
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

We are running rseq selftests on 5.4.199 kernel with  glibc 2.34
version  and we see that tests are failing to compile with invalid
argument errors. When we took all the commits from
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/tools/testing/selftests/rseq
 related to rseq locally , test cases have passed. I see that there are
some adaptations to the latest glibc version done in those commits, is
there any plan to backport them to 5.4.x versions. Could you please
provide your inputs.

Regards,
Rajesh.
