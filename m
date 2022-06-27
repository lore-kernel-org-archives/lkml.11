Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD88C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 12:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiF0MnV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiF0MnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:43:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924519594
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656333798; x=1687869798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vwz7bmQD4OdB7Emg/R0Jhl8SPIRZVhFwD9Lti6y7hs4=;
  b=IiAT+HIW2Kx31Ic6qOkw6OrVL0nSxWdVMjLYkNs6iy13SRuz+abFTwy2
   xl8Wt8QSgoA1x3pxOu/5TMZbOTrzw0EajD6+O4JddT9DrSolt1epQolOo
   ZXLvBZZp8CS8cQ8kirH6RprJc911A0HPYezTocBXB8rhV/PD/ZRuM8WIS
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 05:43:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 05:43:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 05:43:17 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 05:43:16 -0700
Date:   Mon, 27 Jun 2022 08:43:14 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <Yrml4mB3sa5fZVJa@qian>
References: <20220625093346.48894-1-linmiaohe@huawei.com>
 <20220625093346.48894-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220625093346.48894-2-linmiaohe@huawei.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 05:33:45PM +0800, Miaohe Lin wrote:
> si->inuse_pages could still be accessed concurrently now. The plain reads
> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
> results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
> races. Note these data races should be ok because they're just used for
> showing swap info.

Was this found by kcsan? If so, it would be useful to record the exact
kscan report in the commit message.
