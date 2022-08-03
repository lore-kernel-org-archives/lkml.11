Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92BC19F2A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 06:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiHCGfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCGfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:35:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1249557258
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:35:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 7so26992939ybw.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drdaKm1rYuNx2R4KHfm7Yuhd8hot7Jil0OwecH2OJZo=;
        b=fA3tCgNA8/kv8khG6b3Xdam/7tcuG+JeJwmweOfpHzpztZAnDserPJvMqR2r2r/C/u
         X49qugF1JZZbrmhbU5EYIaMrcPuC/uhPzpYccgsscTQnftqdUQTDgaxEVpLDwdH6X0bh
         mAOTqV9zaajB6c+182EQqxsb1NVnGj70hK7/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drdaKm1rYuNx2R4KHfm7Yuhd8hot7Jil0OwecH2OJZo=;
        b=fZ2d8kC5I8vItWndhmL/ThzpbTtG4RgE+ZIeACpiXUnxP78zXaa1+4XS9ZSbyN3JND
         3uQ/nRbaYJfJISX/t9bp+VpVTHEjpjvIuShCJ2MoiXepXtGSxqSTcNY8AYVmUduxaElE
         6k8G3/GdxbJ8XLv6mMYcWlJNx4ggKRjrnWg49dN7BP4MNEJgXvymhyUXLUdcKE27+c02
         bevoTOA+RCF6I7pYYsRmvtTt3wufvSVNhFVIW5poFwzRVivD+mTlHlZhuAPTdbg9RQMb
         PpyE5ypc2KCeyXNphO4auwGA5dxabtuBZMfpefr8CCmmyp+I5OPBqEPP++sqgfnHJVRJ
         pbuA==
X-Gm-Message-State: ACgBeo2I6mjIUi3IE1itCRlRiUfGJ37aC3vDmkFdvNssscKP/y2AWrZi
        OQuVFdqR8qo1N/g4WKAhAA9PdiU1OKHKjOpBYNi12PSdepg=
X-Google-Smtp-Source: AA6agR7dFKricjPxEoi6JyVu40+XkuE9ZHzhJkC86xfuVNHsey1GnmspDjZQ3n+eC17M2de7P8dtpd1WNS1Vahex1BI=
X-Received: by 2002:a25:c206:0:b0:67a:6ba0:98f5 with SMTP id
 s6-20020a25c206000000b0067a6ba098f5mr1253055ybf.507.1659508506351; Tue, 02
 Aug 2022 23:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com>
In-Reply-To: <YuoRuP2pxgSQ6c9E@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 3 Aug 2022 16:34:55 +1000
Message-ID: <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is this information not also in the Documentation/ABI/ entries as
> well?
How would you want me to word it in there? For each entry? There
will be more in the future, would we need to just copy it as a
boilerplate? Bart suggested it be added in the code, do you see
a good way to mention the same in the doc?
Thanks,
--Daniil
