Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5396C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 16:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbiFFQnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiFFQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:43:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85553A4A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654533779; x=1686069779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZU9NUTFu48CfY0LMclqxeVvNVtz2AA0DNT4zjmIRCHc=;
  b=K9l4iiUF0kTLpBgx78d6J0gAck9BjLACG71sjj8nMdDR5slWrgykTf93
   Wq4w8PRntYXq/niInUTZKVjWIwkTNfqDvEKQwZ6b+mloO7oRHcxbbWNB+
   NHOZBFNOal1yWVHfppLi94b/n77Bv/jafkTkC73JpOLWwK4/IVGQWTNah
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 09:42:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:42:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 09:42:58 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 09:42:57 -0700
Date:   Mon, 6 Jun 2022 12:42:55 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Message-ID: <Yp4uj/fGd56ku8SM@qian>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220504010716.661115-10-Liam.Howlett@oracle.com>
 <Yp3yYmNJ5dd8g8Ur@qian>
 <20220606161612.ujglo6i3zbnrygqs@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220606161612.ujglo6i3zbnrygqs@revolver>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:16:27PM +0000, Liam Howlett wrote:
> Does your fuzzer create a reproducer at all?  It would be helpful a lot
> since I cannot see my bug right now.

The same reproducer that running it over the weekend.

$ trinity -C 160
