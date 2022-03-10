Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0481C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 05:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiCJFBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 00:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiCJFBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:01:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EC12D900
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:00:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id p8so4130399pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmlaOnkXV7gYyLatHTSFHCOo07Z7E4KBwil1Hrfv+RU=;
        b=3EvzZ+84RIgKTLctT8/y9GJHmgVsI6b4yA09fCZK8D8rSU7jje0P3SaX7vJ5E6odJr
         LypsvJNqpS7Q9j7Et9R7THMRpBEZNkm6HdnWVdhQcDhOg/EWYxuHvg0yMvrSAJ3oNgX9
         1AAXNJzrcQRuPmBGUWaWTlmiCdmUx7620ZO/WC4V8L1k0omnYrTu+cxMc75J8FGBHo8E
         687a4KVAbdp0l+v8VfxpynWaW3387DvK1O+lryZHb2flExlJYVcOlhZbPfcZi6n3q84w
         YKp0ocBTueQ8x7IHZJ9XRirP1Z+iJhlTg7C46Y4ki4zeX2f4QXz0YWHC2r2C5V/nunJK
         nMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmlaOnkXV7gYyLatHTSFHCOo07Z7E4KBwil1Hrfv+RU=;
        b=wkZv3yEAebonP3MZ1v/xb0YofVDd/2P6w9W41ZzSVR9hhJZEt+rrzEDcW3BbFMcgIy
         iEwSTUfJJsAj4aU44ithUguM5zxv8X19hEHuh6LslltT0gYNK40I0S8PEXWtYBbPgaZC
         RdPjy6IrKRNCF0s5CFy3ouAgYlCgyhWMOc1BDVNpgqsJC/rbBpetC3kBPNqRksNzgE/d
         8mnu20gu64JNgAT9NKxaj3aOfbovT+TBav8lK9Zu6haA8bKGSe+3bRM3oeV622tezL5B
         I+BSckcJQ4UMfsTe89PXd0qZxdxiOeiKnk6il3M+8/pd9MOPyg/MhJVP1oVuiSWVaGIq
         g6AA==
X-Gm-Message-State: AOAM532FPtGJkwJBLhsD5JdJO4D0s/ieWsLSt7BDODHWsgf1A9yUHF1q
        nhQ7cTAlLqjpwWI+twf5UocB9Xj1mDMzXTy791VOpA==
X-Google-Smtp-Source: ABdhPJxJ3M1uMJPPOfvSe4qNin9BErn7l9aDnJzi2AxsDSjcSEqvSkUiqDcMjN3WNNEuA4WH+wsk5FV8ARDID94jxD8=
X-Received: by 2002:a63:2a43:0:b0:376:4b9:f7e0 with SMTP id
 q64-20020a632a43000000b0037604b9f7e0mr2556716pgq.437.1646888408526; Wed, 09
 Mar 2022 21:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20220225143024.47947-1-kjain@linux.ibm.com> <38ab9d45-e756-80b2-1b56-287c43c84ca2@linux.ibm.com>
In-Reply-To: <38ab9d45-e756-80b2-1b56-287c43c84ca2@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 20:59:57 -0800
Message-ID: <CAPcyv4ih7Ur_L_=Zce0h5CUSCr1MfqzNdo3-azygT_e9qgDB2g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add perf interface to expose nvdimm
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 9:27 PM kajoljain <kjain@linux.ibm.com> wrote:
>
> Hi Dan,
>     Can you take this patch-set if it looks fine to you.
>

Pushed out to my libnvdimm-pending branch for a 0day confirmation
before heading over to linux-next.
